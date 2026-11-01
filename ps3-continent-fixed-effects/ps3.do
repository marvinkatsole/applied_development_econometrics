************************ Data preparation ******************************
*** Setting up the directory ***

*** Name: Marvin Katsole *** 

clear
* Run from the repository root (File > Change Working Directory, or: cd "path/to/applied-dev-econometrics")
use "data/alesina_2013_forshare.dta", clear

***1.	Determine the data structure: Is it cross-sectional, time-series, or panel data? Explain.
describe 
duplicates report country

*** Answer: The data are cross-sectional: each observation is a country, observed once, with outcomes measured around one point in time. Looking at the data strcutre through the describe funtion actually allows to see that no variable that reports repeated observations of the same country over time. To increase certainity a bit further, I have looked for duplicates of countries which shows that most countries appear exactly once in the data (except??). Without repetion across time, the data cannot be time-series (one unit across different time-periods) nor panel (different units over different periods). 

*** 2.	Exploring Geographical Variation:


*** a.	Column (2) introduces continent fixed effects. Tabulate `continent' variable and report the table (list of continents recorded, frequency, and their percent).

tabulate continent 

*** Answer: There are 6 continents reported in the data. Africa's frequency is 57, percent is 25. Asia's frequency is 50, percent is 21.93. Europe's frequency is 44, percent is 19.30. North America's frequency is 37, percent is 16.23. Oceania's frequency is 26, percent is 11.40. South America's frequency is 14, percent is 6.14.

***   Continent |      Freq.     Percent        Cum.
***--------------+-----------------------------------
***       Africa |         57       25.00       25.00
**        Asia |         50       21.93       46.93
***       Europe |         44       19.30       66.23
***North America |         37       16.23       82.46
***      Oceania |         26       11.40       93.86
***South America |         14        6.14      100.00
***--------------+-----------------------------------
***        Total |        228      100.00


*** b.	Create a box plot showing the distribution of `flfp2000' by continent. Discuss any patterns you observe across continents.

graph box flfp2000, over (continent)

*** Answer: Femlae labour force particpation across different countries differs, in overall level and also spread. The median for africa in terms of female force paricaption in 2000 is around 62% and the widest range across continents (21% to 90%). The other continents have faily similar patterns with their median being in between 45-55%.  For Europe there are some outliers that are not within the common spread observed across the data. The patterns observed here, can be interpreted as broadly being in line with the argument of Alesina et al. Sub-Sahara Africa is the region with the lowest traditional plough use and it seems to be that this also refelcts in female labour force particpation in 2000. However, this is merely descriptive. 

*** 3.	Fixed Effects Model:
*** a.	Implement a fixed effects model using continent as the fixed effect. 
encode continent, gen (continent_id)
tab continent_id

reg flfp2000 plow tropical_climate agricultural_suitability large_animals political_hierarchies economic_complexity i. continent_id, vce(robust)


*** Adding the degrees of freedom



*** b.	Report and interpret the new results for the `plow' coefficient.

*** The coefficient for the plough use in the model including fixed effects is -15.962, Standard error 3.881, which matches the results provided in table III column (3). That means that societies with full plough ancestry (plow= 1) have, on average, 15.962 percetnage points lower levels of female labour force particpation in 2000 than countries without plough ancestry (plow = 0), holding the five historical and geograhical controls constant and comparing countries within the same continent. This association is stastisitcally significant at the 1% level (p<0.001). 

*** c.	Compare this result with the results from Column (1). How does controlling for continent-specific effects impact the relationship between plough use and FLFP in 2000? 

*** Adding continent fixed efffexts does not impact the relationship much. Compared to the results in column (1), the coefficient moves from -14.90 to -15.92 in Coloumn (2), remaning negative and signfiancnt at the 1% level. The slight increase in magnitatue is small relative to the standard errors, so the two estimates are not meanigfully different. This further suggest, that the association is not driven by broad differences between continent. Even when comparing countries within the same continent, those socieities with more traditioanl plough use tend to have lower levels of female labour force particpation. The size of the R-squared and adjusted R-squared increases slightly, by about 0.04 points for both metrics, showing that inclduing the continent dummy variables in the model does allow to explain some additional variation in female labour force paricaption. 
