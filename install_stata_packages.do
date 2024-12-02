* Stata installer to install commonly used Stata packages

foreach package in "asdoc" "avar" "bacondecomp" "ssaggregate" "bcuse" "boottest" "coefplot" "countyfips" "csdid" "did_multiplegt" "did2s" "drdid" "egenmore" "estout" "esttab" "estwrite" "eventstudyinteract" "ftools" "gtools" "ivreg2" "maptile" "spmap" "ppmlhdfe" "ranktest" "reghdfe" "stackedev" "synth" "statastates" "synth2" "tuples" "vcemway" "wooldid" "wyoung" {
    ssc install `package', replace
    display "Installed package: `package'"
}

display "All packages installed successfully!"
