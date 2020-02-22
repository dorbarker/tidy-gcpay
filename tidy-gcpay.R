library(tibble)
library(readxl)
library(tidyr)
library(optparse)
library(purrr)
library(dplyr)
library(lubridate)


Gget_options <- function() {
    
    OptionParser() %>%
        
        add_option(c('-i', '--input'),
                   help = 'Pay summary from MyGCPay',
                   metavar = 'PATH') %>%
        
        add_option(c('-o', '--output'),
                   help = 'Output path for tidy pay summary',
                   metavar = 'PATH') %>%
        
        parse_args()
}

read_pay_table <- function(input_path) {

    renaming_function <- compose(~ gsub(' ', '_', .), tolower)
    
    original_table <-
        input_path %>%
        read_xlsx %>% 
        rename_all(renaming_function)
    
    original_table
}

tidy_pay <- function(original_table) {

    clean_dollar_values <- compose(as.numeric, ~ gsub('[\\$,]', '', .))
    
    tidy_table <-
        original_table %>%
        separate(pay_week, 
                 sep = '-', 
                 into = c('pay_week_start', 'pay_week_end')) %>%
        mutate(
            # Dates
            pay_date       = mdy(pay_date),
            pay_week_start = mdy(pay_week_start),
            pay_week_end   = mdy(pay_week_end),
            
            # Dollars
            gross          = clean_dollar_values(gross),
            taxes          = clean_dollar_values(taxes),
            deductions     = clean_dollar_values(deductions),
            net            = clean_dollar_values(net)
        )
        
    tidy_table
}

write_pay_table <- function(output_path, tidy_table) {
    
}

main <- function() {
    
    args <- get_options()
    
    original_table <- read_pay_table(args$input)
}

main()