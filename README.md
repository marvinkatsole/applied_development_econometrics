# Foundations of Applied Development Econometrics – Problem Sets

Stata code and write-ups for the weekly problem sets in DV494 (LSE), Autumn 2026.
Author: Marvin Katsole

| Week | Folder | Topic | Data |
|------|--------|-------|------|
| PS1 | `ps1-plough-and-gender-roles/` | Naive vs. controlled OLS: traditional plough use and female labour force participation (Alesina, Giuliano & Nunn 2013) | `alesina_2013_forshare.dta` |
| PS2 | `ps2-trade-openness-government-size/` | Multiple regression, dummies and interactions; replicating Rodrik (1998) with World Development Indicators | `wdi_forshare.dta` |
| PS3 | `ps3-continent-fixed-effects/` | Data structure and continent fixed effects in the plough/FLFP regressions | `alesina_2013_forshare.dta` |

## How to run

1. Clone or download this repository.
2. In Stata, set the working directory to the repository root:
   ```stata
   cd "path/to/applied-dev-econometrics"
   ```
3. Run any problem set, e.g. `do ps2-trade-openness-government-size/ps2.do`

PS2 needs the `distinct` package: `ssc install distinct`.

## Data

- `alesina_2013_forshare.dta`: country-level extract based on Alesina, Giuliano & Nunn (2013), "On the Origins of Gender Roles: Women and the Plough", *QJE*.
- `wdi_forshare.dta`: World Bank World Development Indicators extract (93 MB, stored with Git LFS). The full WDI is available at https://databank.worldbank.org/source/world-development-indicators.

## References

- Alesina, A., Giuliano, P., & Nunn, N. (2013). On the origins of gender roles: Women and the plough. *Quarterly Journal of Economics*, 128(2), 469–530.
- Rodrik, D. (1998). Why do more open economies have bigger governments? *Journal of Political Economy*, 106(5), 997–1032.
