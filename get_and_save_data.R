## install.packages('readr', 'curl', 'odbc', 'dbi', 'ggforce')

# Get data
childcare_costs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-09/childcare_costs.csv')
counties <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-09/counties.csv')

# SQL Connection
# Tip: you can use a docker container to obtain SQL Server
# docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=PASSWORD" -p 1433:1433 --name sqlserver -d mcr.microsoft.com/mssql/server:2019-latest
# be sure your container is running using  'docker ps -a' on your terminal 
# It's necesary to use Depending on your operating system this will diffeer
# you will need packages unixODBC y FreeTDS, odbcListDrivers() will list the drivers available,
# to run the sqlserver use: docker start sqlserver
library(DBI)
library(odbc)

# Establish connection to the sql server
con <- dbConnect(odbc::odbc(), 
                 driver = "FreeTDS",
                 server = "localhost,1433", 
                 uid = "sa", 
                 pwd = "Passpasspass_10" ) # best practise is to load the password from other file that is git ignored

# Query to create childcare_costs table
query_create_childcare_table <- "
CREATE TABLE childcare_costs (
    county_fips_code FLOAT,
    study_year FLOAT,
    unr_16 FLOAT,
    funr_16 FLOAT,
    munr_16 FLOAT,
    unr_20to64 FLOAT,
    funr_20to64 FLOAT,
    munr_20to64 FLOAT,
    flfpr_20to64 FLOAT,
    flfpr_20to64_under6 FLOAT,
    flfpr_20to64_6to17 FLOAT,
    flfpr_20to64_under6_6to17 FLOAT,
    mlfpr_20to64 FLOAT,
    pr_f FLOAT,
    pr_p FLOAT,
    mhi_2018 FLOAT,
    me_2018 FLOAT,
    fme_2018 FLOAT,
    mme_2018 FLOAT,
    total_pop FLOAT,
    one_race FLOAT,
    one_race_w FLOAT,
    one_race_b FLOAT,
    one_race_i FLOAT,
    one_race_a FLOAT,
    one_race_h FLOAT,
    one_race_other FLOAT,
    two_races FLOAT,
    hispanic FLOAT,
    households FLOAT,
    h_under6_both_work FLOAT,
    h_under6_f_work FLOAT,
    h_under6_m_work FLOAT,
    h_under6_single_m FLOAT,
    h_6to17_both_work FLOAT,
    h_6to17_fwork FLOAT,
    h_6to17_mwork FLOAT,
    h_6to17_single_m FLOAT,
    emp_m FLOAT,
    memp_m FLOAT,
    femp_m FLOAT,
    emp_service FLOAT,
    memp_service FLOAT,
    femp_service FLOAT,
    emp_sales FLOAT,
    memp_sales FLOAT,
    femp_sales FLOAT,
    emp_n FLOAT,
    memp_n FLOAT,
    femp_n FLOAT,
    emp_p FLOAT,
    memp_p FLOAT,
    femp_p FLOAT,
    mcsa FLOAT,
    mfccsa FLOAT,
    mc_infant FLOAT,
    mc_toddler FLOAT,
    mc_preschool FLOAT,
    mfcc_infant FLOAT,
    mfcc_toddler FLOAT,
    mfcc_preschool FLOAT
);"

# Execute query and create data on the table
dbExecute(con, query_create_childcare_table, immediate = TRUE)
dbWriteTable(con, "childcare_costs", childcare_costs, overwrite = TRUE, header = TRUE)

# Save counties data to table
query_create_counties_table <- "
CREATE TABLE counties (
    county_fips_code FLOAT,
    county_name NVARCHAR(255),
    state_name NVARCHAR(255),
    state_abbreviation NVARCHAR(2)
);"
dbExecute(con, query_create_counties_table, immediate = TRUE)
dbWriteTable(con, "counties", counties, overwrite = TRUE)
