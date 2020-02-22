# Who made this?

(c) 2020 Dillon O.R. Barker

I made this on my own time, and it is **not** an official work of the Government of Canada or the Public Health Agency of Canada.  

# How do I use this?

```
R -e "install.packages('tidyverse')"  # Install tidyverse if you don't have it
Rscript tidy-gcpay.R -i "Paycheck history.xlsx" -o paycheque_history.tsv
```

# What Does This Do?

Converts MyGCPay's exported Excel file, which has some un-tidy anti-features into a tab-separated variable (TSV) file with tidy data.

Problems with the original format:
1. It's a `.xlsx` binary file, and thus difficult to use outside Microsoft Excel
2. Spaces in column headers are minor nuisance
3. Dates are given as `Feb 22, 2020` which frustrates date parsing and sorting 
4. Multi-variable column `Pay Week` complicates parsing date ranges
5. Dollar values are given as `$1,234.56` which unnecessarily complicates numerical operations

What `tidy-gcpay.R` does to fix these:
1. Outputs a tab-delimited text file readable by anything
2. `Pay Date` becomes `pay_date`, `Check Number` becomes `cheque_number`, _etc_
3. `Feb 22, 2020` becomes `2020-02-22`
4. `Pay Week` with values like `Jan 23, 2020-Feb 5, 2020` becomes `pay_week_start` with `2020-01-23` and `pay_week_end` with `2020-02-05`
5. The string `$1,234.56` becomes the number `1234.56`

# Who can use this?
Anyone — it's MIT licenced — but only employees of the Government of Canada are likely to find it at all useful.
