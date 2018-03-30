
#Plot the 30-day mortality rates for heart attack

#install.packages("data.table")
library("data.table")

# Reading in data
outcome <- data.table::fread('./data/outcome-of-care-measures.csv')
outcome[, (11) := lapply(.SD, as.numeric), .SDcols = (11)]
outcome[, lapply(.SD
                 , hist
                 , xlab= "Deaths"
                 , main = "Hospital 30-Day Death (Mortality) Rates from Heart Attack"
                 , col="lightblue")
        , .SDcols = (11)]

# Finding the best hospital in a state

best <- function(state, outcome) {

  # Read outcome data
  out_dt <- data.table::fread('./data/outcome-of-care-measures.csv')

  outcome <- tolower(outcome)

  # Column name is same as variable so changing it
  chosen_state <- state

  # Check that state and outcome are valid
  if (!chosen_state %in% unique(out_dt[["State"]])) {
    stop('invalid state')
  }

  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop('invalid outcome')
  }

  # Renaming Columns to be less verbose and lowercase
  setnames(out_dt
           , tolower(sapply(colnames(out_dt), gsub, pattern = "^Hospital 30-Day Death \\(Mortality\\) Rates from ", replacement = "" ))
  )

  #Filter by state
  out_dt <- out_dt[state == chosen_state]

  # Columns indices to keep
  col_indices <- grep(paste0("hospital name|state|^",outcome), colnames(out_dt))

  # Filtering out unnessecary data
  out_dt <- out_dt[, .SD ,.SDcols = col_indices]

  # Find out what class each column is
  # sapply(out_dt,class)
  out_dt[, outcome] <- out_dt[,  as.numeric(get(outcome))]


  # Removing Missing Values for numerical datatype (outcome column)
  out_dt <- out_dt[complete.cases(out_dt),]

  # Order Column to Top
  out_dt <- out_dt[order(get(outcome), `hospital name`)]

  return(out_dt[, "hospital name"][1])

}

