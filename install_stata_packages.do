* Stata installer to install commonly used Stata packages

foreach package in "asdoc" "avar" "bacondecomp" "ssaggregate" "bcuse" "boottest" "coefplot" "countyfips" "csdid" "did_imputation" "did_multiplegt" "did2s" "drdid" "egenmore" "estout" "estwrite" "eventstudyinteract" "ftools" "gtools" "ivreg2" "maptile" "outreg2" "ppmlhdfe" "psacalc" "ranktest" "reghdfe" "spmap" "stackedev" "synth" "statastates" "synth2" "tuples" "vcemway" "winsor2" "wooldid" "wyoung" "numdate" {
    ssc install `package', replace
    display "Installed package: `package'"
}

display "All packages installed successfully!"
