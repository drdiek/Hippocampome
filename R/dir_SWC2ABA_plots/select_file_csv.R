clr <- function() cat("\014")

select_file_csv <- function() {
  fileDir <- "data"
  
  csvFiles <- list.files(fileDir, pattern="*.csv")
  nCsvFiles <- length(csvFiles)
  print(nCsvFiles)
  
  reply <- ""
  
  # main loop to display menu choices and accept input
  # terminates when user chooses to exit
  while (reply == "") {
    ## display menu ##
    
    clr() 
    
    strng <- "Please select your .csv file from the selections below:\n"
    print(strng)
    cat("\n")
    
    for (i in 1:nCsvFiles) {
      strng <- sprintf("    %2d) %s", i, csvFiles[[i]])
      print(strng)
    }   
    
    print("     !) Exit")
    cat("\n")
    
    reply <- readline(prompt="Your selection: ")
    
    ## process input ##
    
    if (reply == "!") {
      csvFileName <- "!"
    } else {
      num <- as.numeric(reply)
      
      if (num <= nCsvFiles) {
        csvFileName <- sprintf("./data/%s", csvFiles[[num]])
      } else {
        reply <- ""
      } # if num
    } # if reply
    
  } # while loop
  
  return(csvFileName)
  
} # select_file_csv
