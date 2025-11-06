* Stata installer to install commonly used Stata packages
#delimit;
foreach package in 
"asdoc" 
"asreg" 
"avar" 
"bacondecomp" 
"ssaggregate" 
"bcuse" 
"boottest" 
"coefplot" 
"countyfips" 
"csdid" 
"did_imputation" 
"did_multiplegt" 
"did2s" 
"drdid" 
"egenmore" 
"estout" 
"estwrite" 
"eventstudyinteract" 
"ftools" 
"gtools" 
"ivreg2" 
"maptile" 
"outreg2" 
"ppmlhdfe" 
"psacalc" 
"rangestat"
"ranktest" 
"reghdfe" 
"spmap" 
"stackedev" 
"synth" 
"statastates" 
"synth2" 
"texdoc" 
"tuples" 
"vcemway" 
"winsor2" 
"wooldid" 
"wyoung" { ;
    ssc install `package', replace;
    display "Installed package: `package'";
};
;
#delimit cr;

display "All packages installed successfully!"