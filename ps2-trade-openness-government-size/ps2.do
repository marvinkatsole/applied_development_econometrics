*** Problem Set 2: Marvin Katsole ***

*** loading the dataset 
clear
* Run from the repository root (File > Change Working Directory, or: cd "path/to/applied-dev-econometrics")
use "data/wdi_forshare.dta", clear


***1.	Data Preparation: 
*** a.	Familiarize yourself with the dataset by answering these questions. How many countries are recorded? Does the dataset include only countries, or are there regions as well?

describe 
distinct CountryCode 
tab CountryName 

*** Answer: The dataset contains 266 distint entries under the countryName variable. However, regions (e.g., Arab World, Africa Eastern and Southern) are also included here which suggests that true number of countries is lower than 266. 

*** b.	The dataset contains more variables than needed. We only need to use "Trade (% of GDP)" and "Expense (% of GDP)" from the `IndicatorName' column. Keep only these two observations.

tab IndicatorName
keep if IndicatorName == "Trade (% of GDP)" | IndicatorName == "Expense (% of GDP)"

*** c.	Since the analysis will be at the country level, remove all region entries from the dataset.

gen byte isagg = 0
foreach c in AFE AFW ARB CEB CSS EAP EAR EAS ECA ECS EMU EUU FCS HIC HPC ///
             IBD IBT IDA IDB IDX INX LAC LCN LDC LIC LMC LMY LTE MEA MIC MNA ///
             NAC OED OSS PRE PSS PST SAS SSA SSF SST TEA TEC TLA TMN TSA TSS ///
             UMC WLD {
    replace isagg = 1 if CountryCode == "`c'"
}
drop if isagg == 1
drop isagg

***d.	The current data format is challenging to use. Convert the wide format to long format using these STATA commands: 
replace IndicatorName = "Trade"   if IndicatorName == "Trade (% of GDP)"
replace IndicatorName = "Expense" if IndicatorName == "Expense (% of GDP)"

reshape long y_, i(CountryCode IndicatorName) j(Year)
reshape wide y_, i(CountryCode Year) j(IndicatorName) string


*** e.	Rename the variables to remove the "y_" prefix. 
rename y_Trade Trade 
rename y_Expense Expense 

*** f.	Determine the number of countries recorded (Hint: use the 'distinct' command (install it with "ssc install distinct")) 
distinct CountryCode

*** Answer: now only 217 countries in the data. 

*** g.	Analyze missing observations. Tabulate how many observations are recorded for each variable (Hint: use the `table' command)
table Year, statistic(count Trade) statistic(count Expense)
misstable summarize Trade Expense

*** Answer: Missing data is a bigger issue for expense than for drade, and specifically before 2000. If the analysis would use 1980 (9 for expense and 121 for trade) or 1990 (35 for expense and 144 for trade), the countries reporting would likely be non-ranodom (probabyl richer countries with more reporting). That is why focusing on 2010 onwards makes probabyl the most sense, giving the more data available for expense. 

*** 2.	We will use our data to produce a graph comparable to Rodrik Figure 1. As in Rodrik (1998), create a scatter plot with `Expense' on the y-axis, and `Trade' (proxying for "openness") in the x-axis. Compare your results with Rodrik's findings. Do you observe a similar pattern?
scatter Expense Trade, ///
    ytitle("Government expense (% of GDP)") xtitle("Trade (% of GDP)")

*** Answer: the plot suggest that there is a postive relationship between trade and government expense. This is simialr to Rodrik's figure 1, so data seems to be consistent with his findings. However, the relationship also shows much more variation tcompared to the OECD sample Rodrik provided. But not surpisirng that this data covers countris at all income levels, and then also most observations are clustered at 60-150% trade, with governemnt expense ranging from about 5% to 90% of GDP. 


*** a.	One potential issue is that we are lumping several years into one figure. Create separate scatter plots for the years 2010 and 2019. Briefly explain your observations. 
twoway (scatter Expense Trade if Year==2010) (lfit Expense Trade if Year==2010), ///
    title("2010") name(g2010, replace)
twoway (scatter Expense Trade if Year==2019) (lfit Expense Trade if Year==2019), ///
    title("2019") name(g2019, replace)
graph combine g2010 g2019

*** Answer: In both 2010 and 2019, the fitted line slpes upward, so that the positive relatinship is consistnet. Still, for 2010 it is slightly steeper than for 2019, indicating that there might be weaker relationship in the latter year. Moreover, both show simialr extreme observations, such as Singapoore. 

*** b.	There seems to be some outliers and we'd like to label country names on the figures, similar to Rodrik (1998). Label them and discuss why they might be different from the other countries and if dropping these countries from the analysis could be justified.
twoway scatter Expense Trade if Year==2019, mlabel(CountryCode) mlabsize(vsmall)
list CountryName Trade Expense if Year==2019 & Trade > 150 & Trade < .

*** Answer: Identified outliers are Singapore (SGP), Malta (MLT), Luxembourg (LUX) and Seychelles (SYC), Timor-Leste (TLS), Marshall Islands (MHL), Kiribati (KIR), Palau (PLW), and Ireland (IRL) and in 2019 also San Marino and Nauru. High trade countries such as (SGP; MALTA; LUX) are small trading or financial hubs whose trade-to-gdp ratios are inflated, so openness means something different for them. The other countries are mostly small, and aid dependent and thus spending is larger relative to GDP. For Ireland, there are things driving the high expense, such as the govnerment bailout in 2010. Dropping those countries can only be justified if we have a reason that those countries bias our estimates, and also if we apply a rule across (so for instance saying that trade above 200% of GDP or expense above 45% of GDP). Idealy one can report results with and without them to increase transparency.  

*** c.	Remove the identified outliers and re-create the scatter plots for 2010 and 2019. Briefly discuss findings. 
* drop the outliers
drop if inlist(CountryCode, "SGP", "MLT", "LUX", "SYC", "TLS", "MHL") | ///
        inlist(CountryCode, "KIR", "PLW", "IRL", "NRU", "SMR")

* checking if they are gone
count if inlist(CountryCode, "SGP", "MLT", "LUX", "SYC", "TLS", "MHL") | ///
        inlist(CountryCode, "KIR", "PLW", "IRL", "NRU", "SMR")
		
* re-create the 2010 and 2019 plots
twoway (scatter Expense Trade if Year==2010) ///
       (lfit Expense Trade if Year==2010), ///
       title("2010 (outliers removed)") ///
       xtitle("Trade (% of GDP)") ytitle("Government expense (% of GDP)") ///
       legend(off) name(g2010_c, replace)

twoway (scatter Expense Trade if Year==2019) ///
       (lfit Expense Trade if Year==2019), ///
       title("2019 (outliers removed)") ///
       xtitle("Trade (% of GDP)") ytitle("Government expense (% of GDP)") ///
       legend(off) name(g2019_c, replace)

graph combine g2010_c g2019_c, ycommon xcommon


*** Answer: After having removed the outliers (Singapore, Malta, Luxembourg, Seychelles, Timor-Leste, Marshall Islands, Kiribati, Palau, Ireland, San Marino and Nauru), the positive relationship between trade openness and government expense persists in 2010 and 2019, with similar slopes in both years. With the extreme cases removed, the pattern is now easier to see. However, the points are widely scattered and trade ranges from roughly 25% to 160% of GDP and government expense ranging from about 5% to 45% of GDP, so trade appears to explain only part of the variation in government size. Overall, the direction of Rodrik's result holds in recent data, but the relationship is much noisier than in his OECD sample. Furthermore, comparing regression estimates with and without outliers could be a potential way to show how much they are affecting the slope. 

*** d.	(optional) The World Development Indicators (WDI) dataset includes indicator variables categorized by countries' income levels and regions such as East Asia and Sub-Saharan Africa. How might the patterns differ across these categories? Download the complete dataset from the World Bank website, analyse these categories, and report your findings.


