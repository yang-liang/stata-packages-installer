# Non-Linear
## log approximation
```stata
************************************************************
* Log approximation to percent change
* ln(x) ≈ x−1  (near x=1), and
* 100*ln(x/x0) ≈ 100*((x/x0)−1) for small changes around x0
************************************************************
clear all
set more off

*************************************************
* Part A: Around 1  → ln(1+g) vs g
*************************************************
range g -0.9 1.5 400         // g is growth: x = 1+g
gen x = 1 + g

gen pct_exact = 100*g        // % change from 1 to x
gen pct_log   = 100*ln(1+g)  // log-percent (exact in logs)
gen err_pp    = pct_log - pct_exact

twoway (line pct_log g) (line pct_exact g, lpattern(dash)), ///
      title("Log-percent vs exact % change (base = 1)") ///
      legend(order(1 "100·ln(1+g)" 2 "100·g = 100·((x−1)/1)")) ///
      xtitle("g (growth, x=1+g)") ytitle("Percent")

*************************************************
* Part B: General base x0 → ln(x/x0) vs (x/x0 − 1)
*************************************************
clear
local x0 = 2
range x 0.5 3.5 400
gen pct_exact_x0 = 100*((x/`x0') - 1)              // % change from x0
gen pct_log_x0   = 100*(ln(x) - ln(`x0'))          // log-percent
gen err_pp_x0    = pct_log_x0 - pct_exact_x0

twoway (line pct_log_x0 x) (line pct_exact_x0 x, lpattern(dash)), ///
      title("Log-percent vs exact % change (base = `x0')") ///
      legend(order(1 "100·ln(x/`x0')" 2 "100·((x/`x0')−1)")) ///
      xtitle("x") ytitle("Percent")

twoway (line err_pp_x0 x), ///
      title("Approximation error around x0 = `x0'") ///
      ytitle("percentage points") xtitle("x")
```
---
## log model
```stata
* Load the example dataset
sysuse nlsw88, clear

* Step 1: Take the log of wages
gen log_wage = log(wage)

local i=80  // percentage change

* Step 2: Create a small change in wage, say a 5% increase
gen wage_5pct_increase = wage * (1+`i'/100)

* Step 3: Calculate the log of the new wage
gen log_wage_5pct = log(wage_5pct_increase)

* Step 4: Compute the actual percentage change in wage
gen pct_change_wage = 100 * (wage_5pct_increase - wage) / wage

* Step 5: Compute the difference in log wages (this approximates the percentage change)
gen diff_log_wage = 100 * (log_wage_5pct - log_wage)

* Display the first few observations for comparison
list wage wage_5pct_increase pct_change_wage diff_log_wage in 1/10

```
---
## Semi-parametric with high-order polynomials
```stata
* Load the example dataset
sysuse auto, clear

* Generate polynomial terms manually
gen mpg2 = mpg^2
gen mpg3 = mpg^3

forv i = 4/15{
	cap drop mpg`i'
	gen mpg`i' = mpg^`i'
}

* Fit linear, quadratic, and cubic models
regress price mpg
predict price_linear, xb

regress price mpg mpg2
predict price_quad, xb

regress price mpg mpg2 mpg3 mpg4 mpg5
predict price_cubic, xb

* Sort data by mpg for smooth plotting
sort mpg

* Plot scatter and fitted lines (sorted for smoothness)
twoway (scatter price mpg, msymbol(oh) mcolor(blue)) ///
       (line price_linear mpg, lcolor(red) lpattern(solid)) ///
       (line price_quad mpg, lcolor(green) lpattern(dash)) ///
       (line price_cubic mpg, lcolor(black) lpattern(dash)), ///
       legend(order(1 "Data" 2 "Linear Fit" 3 "Quadratic Fit" 4 "10th Polynomial Fit")) ///
       title("Polynomial Regression of Price on MPG") ///
	   scheme(s1mono)
```
---
## Interactions
```stata
//======================== example 1 =======================================//

// Load dataset and clear any existing data
sysuse nlsw88, clear 

// Rename 'tenure' to 'experience' for clarity
rename tenure experience

// Regress wage on grade (education level), experience, and their interaction
reg wage grade experience c.grade#c.experience

// Calculate predicted wages for specific values of experience and grade
margins, at(experience=(0(5)40) grade=(8 12 16))

// Plot predicted wages with labels and formatting
marginsplot, xlabel(0(5)40) ylabel(, angle(horizontal)) ///
    title("Predicted Wages: Return to Education by Experience") ///
    ytitle("Predicted Wage") xtitle("Experience") legend(on) ///
    plotregion(margin(zero)) scheme(s1mono) 


//======================== example 2 =======================================//
// Load dataset and rename variables for clarity
sysuse nlsw88, clear 
rename tenure experience
rename collgrad college

// Model 1: Basic Model Without Interaction
// Regress wage on experience and college graduation status
reg wage experience i.college 

// Calculate predicted wages by college status at various levels of experience
margins, at(experience=(0(5)40) college=(0 1))

// Plot predicted wages for college and non-college graduates over experience levels
marginsplot, xlabel(0(5)40) ylabel(, angle(horizontal)) ///
    title("Predicted Wages: Effect of College by Experience") ///
    ytitle("Predicted Wage") xtitle("Experience") legend(on) ///
    plotregion(margin(zero)) scheme(s1mono) 


// Model 2: Adding an Interaction Between College and Experience
// Regress wage on experience, college status, and their interaction
reg wage experience i.college i.college#c.experience

// Calculate and plot predicted wages with the interaction effect
margins, at(experience=(0(5)40) college=(0 1))
marginsplot, xlabel(0(5)40) ylabel(, angle(horizontal)) ///
    title("Predicted Wages: Effect of College by Experience") ///
    ytitle("Predicted Wage") xtitle("Experience") legend(on) ///
    plotregion(margin(zero)) scheme(s1mono) 


// Model 3: Interaction Effect Only
// Model focusing solely on the interaction effect without main college status
reg wage experience i.college#c.experience

// Calculate and plot predicted wages based only on interaction term
margins, at(experience=(0(5)40) college=(0 1))
marginsplot, xlabel(0(5)40) ylabel(, angle(horizontal)) ///
    title("Predicted Wages: Effect of College by Experience") ///
    ytitle("Predicted Wage") xtitle("Experience") legend(on) ///
    plotregion(margin(zero)) scheme(s1mono) 
```
