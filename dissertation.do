*dissertation.do

/*******************************************************************************
 Step0: Path & Summary
*******************************************************************************/
*Path
global Data "/Users/Amartya/Desktop/Dr RAP/Miscellaneous/LSE MSc/Dissertation/Data"
/*
 Summary: Here we are trying to find the impact of monetary policy on commodity 
         prices using Local Projections - Instrumental Variables approach
*/

/*
Contents: 

 Step1: Non Metal FRED
 Step2: Agriculture Macro Trends 
 Step3: Metals Capital IQ Pro
 Step4: Asset Prices Merge
 Step5: Instruments Data 
 Step6: Interest Rate Data 
 Step7: Liquidity Data
 Step8: Final Merge 
 Step9: LP-IV
 Step10: Interest Rate State Dependency 
 Step11: Liquidity State Dependency 
*/

/*
 Step 1,2,3 includes cleaning and formating the commodities data into desired format 
 Step 4 is just a merge of the above three steps 
 Step 5,6,7 includes cleaning and formating the monetary policy data
 Step 8 is the final merge to get the desired dataset ready for analysis
 Step 9,10,11 are regression results. 9 being plain vanilla, 
                                      10 and 11 include state dependency
*/

/*******************************************************************************
 Step1: Non Metal; Source: FRED
*******************************************************************************/
*1)Crude Oil
import delimited "$Data/Non Metal FRED/CrudeOil.csv", clear 
ren dcoilwtico crudeoil

gen year = real(substr(date, 1, 4))
gen month = real(substr(date, 6, 2))
gen day = real(substr(date, 9, 2))

replace crudeoil=crudeoil[_n-1] if crudeoil==. //fill missing values with the previous values

by year month, sort: gen byte last_forecast = (_n == _N)

drop if last_forecast != 1

ren date modate 

gen date = ym(year, month)
format date %tm
keep date crudeoil
order date crudeoil

save "$Data/Refined Data/crudeoil.dta", replace 

*2)Natural Gas 
import delimited "$Data/Non Metal FRED/NaturalGas.csv", clear 
ren pngaseuusdm naturalgas

gen year = real(substr(date, 1, 4))
gen month = real(substr(date, 6, 2))
gen day = real(substr(date, 9, 2))

replace naturalgas=naturalgas[_n-1] if naturalgas==.

by year month, sort: gen byte last_forecast = (_n == _N)

drop if last_forecast != 1

ren date modate 

gen date = ym(year, month)
format date %tm
keep date naturalgas
order date naturalgas

save "$Data/Refined Data/naturalgas.dta", replace 

/*******************************************************************************
 Step2: Agriculture; Source: Macro Trends
*******************************************************************************/
*1)Coffee
import delimited "$Data/Agriculture Macro Trends/coffee.csv", clear 

drop in 1/8
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
gen year = real(substr(date, 1, 4))
gen month = real(substr(date, 6, 2))
gen day = real(substr(date, 9, 2))
destring _value, replace 
replace _value=_value[_n-1] if _value==.
by year month, sort: gen byte last_forecast = (_n == _N)
drop if last_forecast != 1
ren date modate 
gen date = ym(year, month)
format date %tm
keep date _value
order date _value

ren _value coffee
save "$Data/Refined Data/coffee.dta", replace 

*2)Corn
import delimited "$Data/Agriculture Macro Trends/corn.csv", clear 

drop in 1/8
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
gen year = real(substr(date, 1, 4))
gen month = real(substr(date, 6, 2))
gen day = real(substr(date, 9, 2))
destring _value, replace 
replace _value=_value[_n-1] if _value==.
by year month, sort: gen byte last_forecast = (_n == _N)
drop if last_forecast != 1
ren date modate 
gen date = ym(year, month)
format date %tm
keep date _value
order date _value

ren _value corn
save "$Data/Refined Data/corn.dta", replace 

*3)Cotton
import delimited "$Data/Agriculture Macro Trends/cotton.csv", clear 

drop in 1/8
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
gen year = real(substr(date, 1, 4))
gen month = real(substr(date, 6, 2))
gen day = real(substr(date, 9, 2))
destring _value, replace 
replace _value=_value[_n-1] if _value==.
by year month, sort: gen byte last_forecast = (_n == _N)
drop if last_forecast != 1
ren date modate 
gen date = ym(year, month)
format date %tm
keep date _value
order date _value

ren _value cotton
save "$Data/Refined Data/cotton.dta", replace 

*4)Oats
import delimited "$Data/Agriculture Macro Trends/oats.csv", clear 

drop in 1/8
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
gen year = real(substr(date, 1, 4))
gen month = real(substr(date, 6, 2))
gen day = real(substr(date, 9, 2))
destring _value, replace 
replace _value=_value[_n-1] if _value==.
by year month, sort: gen byte last_forecast = (_n == _N)
drop if last_forecast != 1
ren date modate 
gen date = ym(year, month)
format date %tm
keep date _value
order date _value

ren _value oats
save "$Data/Refined Data/oats.dta", replace 

*5)Soy Bean
import delimited "$Data/Agriculture Macro Trends/soybean.csv", clear 

drop in 1/8
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
gen year = real(substr(date, 1, 4))
gen month = real(substr(date, 6, 2))
gen day = real(substr(date, 9, 2))
destring _value, replace 
replace _value=_value[_n-1] if _value==.
by year month, sort: gen byte last_forecast = (_n == _N)
drop if last_forecast != 1
ren date modate 
gen date = ym(year, month)
format date %tm
keep date _value
order date _value

ren _value soybean
save "$Data/Refined Data/soybean.dta", replace 

*6)Sugar
import delimited "$Data/Agriculture Macro Trends/sugar.csv", clear 

drop in 1/8
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
gen year = real(substr(date, 1, 4))
gen month = real(substr(date, 6, 2))
gen day = real(substr(date, 9, 2))
destring _value, replace 
replace _value=_value[_n-1] if _value==.
by year month, sort: gen byte last_forecast = (_n == _N)
drop if last_forecast != 1
ren date modate 
gen date = ym(year, month)
format date %tm
keep date _value
order date _value

ren _value sugar
save "$Data/Refined Data/sugar.dta", replace 

*7)Wheat
import delimited "$Data/Agriculture Macro Trends/wheat.csv", clear 

drop in 1/8
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
gen year = real(substr(date, 1, 4))
gen month = real(substr(date, 6, 2))
gen day = real(substr(date, 9, 2))
destring _value, replace 
replace _value=_value[_n-1] if _value==.
by year month, sort: gen byte last_forecast = (_n == _N)
drop if last_forecast != 1
ren date modate 
gen date = ym(year, month)
format date %tm
keep date _value
order date _value

ren _value wheat
save "$Data/Refined Data/wheat.dta", replace 

/******************************************************************************
 Step3: Metals; Source: Capital IQ Pro 
*******************************************************************************/

*1)Aluminium
import excel "$Data/Metals Capital IQ Pro/Aluminum.xls", sheet("Data") clear
drop in 1/9
drop in 511
keep A C
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
split Date, parse(/) 
drop Date2
destring Date1 Date3, replace 
ren Date1 month 
ren Date3 year
gen date = ym(year, month)
format date %tm
ren LME_Aluminium_99_7__Cash____tonn value
destring value, replace 
keep date value
order date value
drop if date==.
sort date 
ren value aluminium
save "$Data/Refined Data/aluminium.dta", replace 

*2)Copper
import excel "$Data/Metals Capital IQ Pro/Copper.xls", sheet("Data") clear
drop in 1/8
drop in 511
keep A C
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
split Date, parse(/) 
drop Date2
destring Date1 Date3, replace 
ren Date1 month 
ren Date3 year
gen date = ym(year, month)
format date %tm
ren LME_Copper_Grade_A_Cash____tonne value
destring value, replace 
keep date value
order date value
drop if date==.
sort date 
ren value copper
save "$Data/Refined Data/copper.dta", replace 

*3)Gold
import excel "$Data/Metals Capital IQ Pro/Gold.xls", sheet("Data") clear
drop in 1/7
drop in 511
keep A B
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
split Date, parse(/) 
drop Date2
destring Date1 Date3, replace 
ren Date1 month 
ren Date3 year
gen date = ym(year, month)
format date %tm
ren LBMA_Gold_Bullion____oz_ value
destring value, replace 
keep date value
order date value
drop if date==.
sort date 
ren value gold
save "$Data/Refined Data/gold.dta", replace 

*4)Lead
import excel "$Data/Metals Capital IQ Pro/Lead.xls", sheet("Data") clear
drop in 1/8
drop in 511
keep A B
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
split Date, parse(/) 
drop Date2
destring Date1 Date3, replace 
ren Date1 month 
ren Date3 year
gen date = ym(year, month)
format date %tm
ren LME_Lead_Cash____tonne_ value
replace value="" if value =="NA"
destring value, replace 
keep date value
order date value
drop if date==.
sort date 
ren value lead
save "$Data/Refined Data/lead.dta", replace 

*5)Nickel
import excel "$Data/Metals Capital IQ Pro/Nickel.xls", sheet("Data") clear
drop in 1/8
drop in 511
keep A B
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
split Date, parse(/) 
drop Date2
destring Date1 Date3, replace 
ren Date1 month 
ren Date3 year
gen date = ym(year, month)
format date %tm
ren LME_Nickel_Cash____tonne_ value
replace value="" if value =="NA"
destring value, replace 
keep date value
order date value
drop if date==.
sort date 
ren value nickel
save "$Data/Refined Data/nickel.dta", replace 

*6)Platinum
import excel "$Data/Metals Capital IQ Pro/Platinum.xls", sheet("Data") clear
drop in 1/8
drop in 511
keep A B
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
split Date, parse(/) 
drop Date2
destring Date1 Date3, replace 
ren Date1 month 
ren Date3 year
gen date = ym(year, month)
format date %tm
ren LBMA_Platinum____oz_ value
destring value, replace 
keep date value
order date value
drop if date==.
sort date 
ren value platinum
save "$Data/Refined Data/platinum.dta", replace 

*7)Silver
import excel "$Data/Metals Capital IQ Pro/Silver.xls", sheet("Data") clear
drop in 1/7
drop in 510/516
keep A B
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
split Date, parse(/) 
drop Date2
destring Date1 Date3, replace 
ren Date1 month 
ren Date3 year
gen date = ym(year, month)
format date %tm
ren LBMA_Silver_Price____oz_ value
destring value, replace 
keep date value
order date value
drop if date==.
sort date 
ren value silver
save "$Data/Refined Data/silver.dta", replace 

*8)Tin
import excel "$Data/Metals Capital IQ Pro/Tin.xls", sheet("Data") clear
drop in 1/9
drop in 511
keep A C
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
split Date, parse(/) 
drop Date2
destring Date1 Date3, replace 
ren Date1 month 
ren Date3 year
gen date = ym(year, month)
format date %tm
ren LME_Tin_99_85__Cash____tonne_ value
destring value, replace 
keep date value
order date value
drop if date==.
sort date 
ren value tin
save "$Data/Refined Data/tin.dta", replace 

*9)Zinc
import excel "$Data/Metals Capital IQ Pro/Zinc.xls", sheet("Data") clear
drop in 1/8
drop in 511
keep A B
foreach var of varlist * {
    rename `var' `=strtoname(`var'[1])'
}
drop in 1
split Date, parse(/) 
drop Date2
destring Date1 Date3, replace 
ren Date1 month 
ren Date3 year
gen date = ym(year, month)
format date %tm
ren LME_SHG_Zinc_99_995__Cash____ton value
destring value, replace 
keep date value
order date value
drop if date==.
sort date 
ren value zinc
save "$Data/Refined Data/zinc.dta", replace 


/*******************************************************************************
 Step4: Asset Prices Merge 
*******************************************************************************/
*merge 

use "$Data/Refined Data/aluminium.dta", clear 
foreach v in copper gold lead nickel platinum silver tin zinc coffee corn cotton crudeoil naturalgas oats soybean sugar{
	merge 1:1 date using "$Data/Refined Data/`v'.dta"
	drop _merge
}
drop in 1/246
save "$Data/Refined Data/assetprices.dta", replace 

use "$Data/Refined Data/assetprices.dta", clear 

/*******************************************************************************
 Step5: Instruments Data 
*******************************************************************************/
*Instruments Gertler &Karadi
import delimited "$Data/Gertler Karadi Code and Data/data/factor_data.csv", clear 
gen date = ym(year, month)
format date %tm
drop month year
order date 
drop in 1/6
save "$Data/Refined Data/instruments.dta", replace 

/*******************************************************************************
 Step6: Interest Rate Data 
*******************************************************************************/
*Interest rates Gertler &Karadi
import delimited "$Data/Gertler Karadi Code and Data/data/VAR_data.csv", clear
gen date = ym(year, month)
format date %tm
ren ff_exp1yr interestrate
keep date interestrate
order date interestrate
drop in 1/6
save "$Data/Refined Data/interestrate.dta", replace 

/*******************************************************************************
 Step7: Liquidity Data 
*******************************************************************************/
import delimited "$Data/Refined Data/M2.csv", clear
save "$Data/Refined Data/M2.dta", replace

import delimited "$Data/Refined Data/GDP.csv", clear 
save "$Data/Refined Data/GDP.dta", replace 

use "$Data/Refined Data/M2.dta", clear 
merge 1:1 date using "$Data/Refined Data/GDP.dta"
drop if _merge ==2
drop _merge
gen year = substr(date,1,4)
gen month = substr(date,6,2)
drop date 
destring, replace 
gen date = ym(year, month)
format %tm date 
drop month
order date
ren mabmm201usq189s m2
tsset date, monthly

gen gdpgrowth = ((gdp-L3.gdp)/(L3.gdp))*100
gen m2growth = ((m2-L3.m2)/(L3.m2))*100

gen excessliq = 0
replace excessliq = 1 if m2growth > gdpgrowth
drop if year <1984
drop year 
keep date excessliq
tsfill
ssc install carryforward
carryforward  excessliq, gen(liq)
drop excessliq
save "$Data/Refined Data/liq.dta", replace 

/*******************************************************************************
 Step8: Final Merge
*******************************************************************************/
*Final Merge 
use "$Data/Refined Data/interestrate.dta", clear 
merge 1:1 date using "$Data/Refined Data/instruments.dta"
drop _merge 
merge 1:1 date using "$Data/Refined Data/assetprices.dta"
drop if _merge!=3
drop _merge
drop in 1/48
merge 1:1 date using "$Data/Refined Data/liq.dta"
drop if _merge!=3
drop _merge
tsset date, monthly
save "$Data/essayfinal.dta", replace 

*Final Data 
use "$Data/essayfinal.dta", clear 

/*******************************************************************************
 Step9: LP-IV 
*******************************************************************************/
clear all
global Data "/Users/Amartya/Desktop/Econ/Dissertation/Data"

*foreach j in mp1_tc ff4_tc ed2_tc ed3_tc ed4_tc {
foreach v in aluminium copper gold lead nickel platinum silver tin zinc coffee corn cotton crudeoil naturalgas oats soybean sugar {
use "$Data/essayfinal.dta", clear 
tsset date 

*aluminium copper gold lead nickel platinum silver tin zinc coffee corn cotton crudeoil naturalgas oats soybean sugar 
gen ASSET= ln(`v') 
gen INTR= interestrate  
gen INSTR= ed2_tc 
gen INTRCHG= D.INTR

keep if ASSET != . 
keep if INTR != .
keep if INSTR != .

* Choose impulse response horizon
local hmax= 60
local lmax= 4

* Generate LHS variables for the LPs 
* Cumulative
qui forvalues h = 0/`hmax' {
	gen ASSET`h' = F`h'.ASSET
	
} 

* LPIV
drop eststo 
cap drop b u d Months Zero
gen Months = _n-1 if _n<=`hmax'
gen Zero = 0 if _n<=`hmax'
gen b=0
gen u=0
gen d=0
qui forvalues h = 1/`hmax' {
	ivregress gmm ASSET`h' L(1/`lmax').INTR L(1/`lmax').ASSET (INTRCHG = INSTR), vce(hac nwest)
replace b=_b[INTRCHG] if _n == `h'
replace u=_b[INTRCHG] + 1.645* _se[INTRCHG] if _n==`h'
replace d=_b[INTRCHG] - 1.645* _se[INTRCHG] if _n==`h'
eststo 
}

/* Use this command if you want a summary of the LP coefficients*/
nois esttab, se nocons keep(INTRCHG)

twoway ///
(rarea u d  Months,  ///
fcolor(purple%15) lcolor(gs13) lw(none) lpattern(solid)) ///
(line b Months, lcolor(purple) lpattern(solid) lwidth(thick)) ///
(line Zero Months, lcolor(black)), legend(off) ///
title("Responses of `v' price to monetary shock", color(black) size(med)) ///
subtitle("IV (solid purple)", color(black) size(small)) ///
ytitle("Percent", size(medsmall)) xtitle("Months", size(medsmall)) ///
note("Notes: 90 percent confidence bands") ///
graphregion(color(white)) plotregion(color(white))
graph save "Graph" "$Data/Graphs/`v'.gph", replace 
}
*}

graph combine "$Data/Graphs/aluminium.gph" "$Data/Graphs/copper.gph" "$Data/Graphs/gold.gph" ///
"$Data/Graphs/lead.gph" "$Data/Graphs/nickel.gph" "$Data/Graphs/platinum.gph" "$Data/Graphs/silver.gph" ///
"$Data/Graphs/tin.gph" "$Data/Graphs/zinc.gph" "$Data/Graphs/coffee.gph" "$Data/Graphs/crudeoil.gph" ///
"$Data/Graphs/naturalgas.gph" "$Data/Graphs/oats.gph" "$Data/Graphs/soybean.gph" "$Data/Graphs/sugar.gph"

graph save "Graph" "$Data/Graphs/combination.gph", replace 
*aluminium copper gold lead nickel platinum silver tin zinc coffee corn cotton crudeoil naturalgas oats soybean sugar

estimates table aluminium copper gold lead nickel platinum silver tin zinc coffee corn cotton///
crudeoil naturalgas oats soybean sugar, se varlabel

putdocx begin
putdocx table results = etable
putdocx save myresults.docx, replace

/*******************************************************************************
 Step10: Interest Rate State Dependency 
*******************************************************************************/

clear all
global Data "/Users/Amartya/Desktop/Econ/Dissertation/Data"

foreach v in aluminium copper gold lead nickel platinum silver tin zinc coffee corn cotton crudeoil naturalgas oats soybean sugar {
use "$Data/essayfinal.dta", clear 
tsset date 

*aluminium copper gold lead nickel platinum silver tin zinc coffee corn cotton crudeoil naturalgas oats soybean sugar 
gen ASSET= ln(`v') 
gen INTR= interestrate  
gen INSTR= ed2_tc 
gen INTRCHG= D.INTR

keep if ASSET != . 
keep if INTR != .
keep if INSTR != .

gen INSTRP = max(0,INSTR) 
gen INSTRN = min(0,INSTR)
gen INTRP = cond(INTRCHG >= 0 , INTRCHG, 0)
gen INTRN = cond(INTRCHG < 0 , INTRCHG, 0)

local hmax = 60
local lmax = 4

qui forvalues h = 0/`hmax' {
	gen ASSET`h' = F`h'.ASSET
}

eststo clear 
cap drop bp bn up un dp dn Months Zero
gen Months = _n-1 if _n <= `hmax'
gen Zero = 0 if _n <= `hmax'
gen bp = 0 
gen bn = 0 
gen up = 0
gen un = 0 
gen dp = 0
gen dn = 0

qui forvalues h = 1/`hmax' {
	ivregress gmm ASSET`h' L(1/`lmax').INTR L(1/`lmax').ASSET (INTRP INTRN = INSTRP INSTRN), vce(hac nwest)
replace bp=_b[INTRP] if _n == `h'
replace up=_b[INTRP] + 1.645* _se[INTRP] if _n==`h'
replace dp=_b[INTRP] - 1.645* _se[INTRP] if _n==`h'
replace bn=_b[INTRN] if _n == `h'
replace un=_b[INTRN] + 1.645* _se[INTRN] if _n==`h'
replace dn=_b[INTRN] - 1.645* _se[INTRN] if _n==`h'
eststo
}

nois esttab, se nocons keep(INTRP INTRN)

twoway ///
(rarea up dp  Months, fcolor(green%30) lcolor(gs13) lw(none) lpattern(solid)) ///
(rarea un dn  Months, fcolor(red%30) lcolor(gs13) lw(none) lpattern(solid)) ///
(line bp Months, lcolor(green) lpattern(solid) lwidth(thick)) ///
(line bn Months, lcolor(red) lpattern(solid) lwidth(thick)) ///
(line Zero Months, lcolor(black)), legend(off) ///
title("Responses of `v' price to monetary shock", color(black) size(med)) ///
subtitle("Green - Positive Shocks; Red - Negative Shocks", color(black) size(small)) ///
ytitle("Percent", size(medsmall)) xtitle("Months", size(medsmall)) ///
note("Notes: 90 percent confidence bands") ///
graphregion(color(white)) plotregion(color(white))
graph save "Graph" "$Data/Graphs/state_`v'.gph", replace 
}

graph combine "$Data/Graphs/state_aluminium.gph" "$Data/Graphs/state_copper.gph" ///
"$Data/Graphs/state_gold.gph" "$Data/Graphs/state_lead.gph" "$Data/Graphs/state_nickel.gph" ///
"$Data/Graphs/state_platinum.gph" "$Data/Graphs/state_silver.gph" "$Data/Graphs/state_tin.gph" ///
"$Data/Graphs/state_zinc.gph" "$Data/Graphs/state_coffee.gph" "$Data/Graphs/state_crudeoil.gph" ///
"$Data/Graphs/state_naturalgas.gph" "$Data/Graphs/state_oats.gph" "$Data/Graphs/state_soybean.gph" ///
"$Data/Graphs/state_sugar.gph" 

graph save "Graph" "$Data/Graphs/state_combination.gph", replace 

/*******************************************************************************
 Step 11: Liquidity State Dependency 
*******************************************************************************/
foreach v in aluminium copper gold lead nickel platinum silver tin zinc coffee corn cotton crudeoil naturalgas oats soybean sugar {
use "$Data/essayfinal.dta", clear 
tsset date 

*aluminium copper gold lead nickel platinum silver tin zinc coffee corn cotton crudeoil naturalgas oats soybean sugar 
gen ASSET= ln(`v') 
gen INTR= interestrate  
gen INSTR= ed2_tc 
gen INTRCHG= D.INTR

keep if ASSET != . 
keep if INTR != .
keep if INSTR != .

gen INTRE = 0
gen INTRL = 0
replace  INTRE = INTR if liq==1
replace  INTRL = INTR if liq==0
gen INSTRE = 0
gen INSTRL = 0
replace  INSTRE = INSTR if liq==1
replace  INSTRL = INSTR if liq==0 

local hmax = 60
local lmax = 4

qui forvalues h = 0/`hmax' {
	gen ASSET`h' = F`h'.ASSET
}

eststo clear 
cap drop be bl ue ul de dl Months Zero
gen Months = _n-1 if _n <= `hmax'
gen Zero = 0 if _n <= `hmax'
gen be = 0 
gen bl = 0 
gen ue = 0
gen ul = 0 
gen de = 0
gen dl = 0

qui forvalues h = 1/`hmax' {
	ivregress gmm ASSET`h' L(1/`lmax').INTR L(1/`lmax').ASSET (INTRE INTRL = INSTRE INSTRL), vce(hac nwest)
replace be=_b[INTRE] if _n == `h'
replace ue=_b[INTRE] + 1.645* _se[INTRE] if _n==`h'
replace de=_b[INTRE] - 1.645* _se[INTRE] if _n==`h'
replace bl=_b[INTRL] if _n == `h'
replace ul=_b[INTRL] + 1.645* _se[INTRL] if _n==`h'
replace dl=_b[INTRL] - 1.645* _se[INTRL] if _n==`h'
eststo
}

nois esttab, se nocons keep(INTRE INTRL)

twoway ///
(rarea ue de  Months, fcolor(blue%30) lcolor(gs13) lw(none) lpattern(solid)) ///
(rarea ul dl  Months, fcolor(yellow%30) lcolor(gs13) lw(none) lpattern(solid)) ///
(line be Months, lcolor(blue) lpattern(solid) lwidth(thick)) ///
(line bl Months, lcolor(yellow) lpattern(solid) lwidth(thick)) ///
(line Zero Months, lcolor(black)), legend(off) ///
title("Responses of `v' price to monetary shock", color(black) size(med)) ///
subtitle("Blue - Excess Liquidity; Yellow - Lack of Liquidity", color(black) size(small)) ///
ytitle("Percent", size(medsmall)) xtitle("Months", size(medsmall)) ///
note("Notes: 90 percent confidence bands") ///
graphregion(color(white)) plotregion(color(white))
graph save "Graph" "$Data/Graphs/liq_`v'.gph", replace 
}

graph combine "$Data/Graphs/liq_aluminium.gph" "$Data/Graphs/liq_copper.gph" ///
"$Data/Graphs/liq_gold.gph" "$Data/Graphs/liq_lead.gph" "$Data/Graphs/liq_nickel.gph" ///
"$Data/Graphs/liq_platinum.gph" "$Data/Graphs/liq_silver.gph" "$Data/Graphs/liq_tin.gph" ///
"$Data/Graphs/liq_zinc.gph" "$Data/Graphs/liq_coffee.gph" "$Data/Graphs/liq_crudeoil.gph" ///
"$Data/Graphs/liq_naturalgas.gph" "$Data/Graphs/liq_oats.gph" "$Data/Graphs/liq_soybean.gph" ///
"$Data/Graphs/liq_sugar.gph" 

graph save "Graph" "$Data/Graphs/liq_combination.gph", replace 


/*******************************************************************************
                                       End
*******************************************************************************/
