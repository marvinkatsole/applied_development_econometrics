************************ Data preparation ******************************
*** Setting up the directory ***

*** Name: Marvin Katsole *** 

clear
* Run from the repository root (File > Change Working Directory, or: cd "path/to/applied-dev-econometrics")
use "data/alesina_2013_forshare.dta", clear

*****Data preparation******

*** Task 1 ***
***1 a.	Identify and keep only the variables necessary for our analysis. ****
*/The relevant variables are: Traditional plough use; agricultural suitability; tropical climate; Presence of large animals; political hierarchies; Economic complexity ; fe*/

 keep flfp2000 plow female_ownership women_politics large_animals political_hierarchies economic_complexity tropical_climate agricultural_suitability

*1 b.  List these variables and explain why each is important.
summarize 
*/Traditiponal plow use ; female labor force participation; share of firms with female ownership; share of political positions heald by women ; agricultural; tropical; presence of large animals; political hierachies ; economic complexity" 
*** Why are they necessary i.	Traditional plough use (plow)--> is the main explanatory variable and thus necessary for the regression ii.	Female labor force participation (`flfp2000') --> is the outcome the regression is trying to explain and thus needs to be part of it iii.	Agricultural suitability (agricultural_suitability) --> Agricultural suitability of the ancestral land decides which crops can be grown and whether the plow was being adopted or not. iv.	Tropical climate (tropical_climate) --> variable controlling for the fact that some climates are more conducive to certain crops which make plough usage more likely. It affects female labor force participation and not including it would bias the plough coefficient. v.	Presence of large animals (large_amimals) --> Plough is being pulled by large animals, and thus societies in which they are present are more likely to use the plough. vi.	Political hierarchies (political_hierarchies) --> Societies which were politically more complex were more likely to adaopt the plough, and political organizations can also shape institutions and gender roles that persist today. vii.	Economic complexity (economic_complexity) --> measures settlement desniyt and economic development, which made plough doption more likely and is thus included as control.***

*1 c. Produce summary statistics for `flfp2000' and `plow'. 
sum flfp2000 plow



******* Task 2: Baseline regression********
*2 a. Run a naïve regression (without any controls or fixed effects) of female labor force participation in 2000 (`flfp2000') on traditional plough use (`plow'). 

reg flfp2000 plow
*2 b. Report and interpret the coefficient, standard error, t-statistic, and p-value for `plow.' 

*/ Coefficient ( -9.974693), standard error ( 2.316325 ), t-statistic (-4.31), p-value ( 0.000 )
*** i.	Coefficient: -9.974693. This is the difference in female labor force participation (in percentage points), between a country with no plough use ancestry (plow = 0) and one in which ancestors made use of the plow. According to the regression, countries with full plough ancestry have about 9.975 points lower female labor force participation than countries with no plough ancestry. ii.	Standard error: 2.316325 (it is small relative to the coefficient) iii.	 T-statistic: -4.31 (it is far beyond 2 and so the estimate based on this regression seems to be different from zero, indicating statistical significance) iv.	P-value: 0.000 (the p-value is very small, and based on this regression, the null hypothesis could be rejected at the 1% level)***


*2 c. Create a scatter plot with `flfp2000' on the y-axis and plough use on the x-axis. Briefly discuss endogeneity concerns and propose specific control variables that might address these concerns.
graph twoway scatter flfp2000 plow

*** Interpretation: i.	The scatter plot shows how female labor force participation actually varies for countries with plough use ancestry and those without this ancestry. Since it varies on both ends, plough use does not seem to be the only predictor of female labor force participation. As no control variables are being included, this could be an indication of omitted variable bias, which was explained earlier. To increase confidence in the estimates, other factors need to be controlled for. These could be controls that are presented in the table, such as tropical climate and agricultural suitability (as geography decides which grops can be grown, and whether the plough was being adopted or not), presence of large animals (for plough use), political hierarchies and economic complexity (more developed societies, more likely to adopt the plough). However, as established earlier factors such as religion, level of income per capita (paper states a relationship between level of development and female labor force participation, or the education (e.g., quality of education). ***



************* Task 3: Multiple Regression with Controls: **********
*3 a.	Introduce the control variables you identified. Run a multiple regression and report and interpret the coefficient on `plow'.
reg flfp2000 plow large_animals political_hierarchies economic_complexity tropical_climate agricultural_suitability

*** Interpretation: i.	The coefficient of plow is now -14.985, meaning that countries with more plough use tend to, on average,have -14.985 percentage points lower levels of female participation in the labor force, holding constant the effect of large animals, agricultural suitability, tropical climate, political hierarchies, and economic complexity. This effect is statistically significant at the 1% level (p = 0.001). b.	Compare the new coefficient ***

 
*3 b.	Compare the new coefficient on `plow' with the baseline regression result.
 ** coefficient (-14.8946)   standard error (3.326097)    t-stastitic (-4.48)   p-value (0.000)
 ***Interpretation: 1.	The coefficient became more negative by about 5 points, from -9.975 points to -14.89 points, while the significance remained the same across both regressions.
 
 
*3 c.	Interpret the coefficient of interest. 
*** i.	Comparing countries with similar tropical climate, large animals, agricultural suitability, political hierarchies and economic complexity, a country with plough ancestry has, on average, about 15 points lower levels of female labor force participation than a country with no plough use ancestry. ***


*3 d.	Explain any changes in the coefficient estimate, considering both magnitude and statistical significance.
*** i.	The coefficient became more negative by about 5 points, from -9.975 points to -14.89 points, while the significance stayed the same at 1% (p<0.001). The naïve regression that was run above perhaps left out factors that affect women's work and are also linked to plough use, so the estimate in the naïve regression was too small. 



