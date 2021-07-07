library(odbc)
library(DBI)

dbconn <- function(x){
  
  dbconnection <-  dbConnect(odbc::odbc(),
                             Driver = "FreeTDS",
                             Server = "10.100.74.211",
                             Database = "mdb",
                             UID = "usr_operapps",
                             PWD = "usr_operapps0318",
                             Port = 1435)
  
  return(dbconnection)
  
}