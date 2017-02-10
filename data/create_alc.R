"Data wrangling exercise 3 - Guilherme Varro . 7th of february, 2017."
"Data SOURCE Alcohol consumption"

math <- student_mat
por <- student_por

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
innerjoin_math_por <- inner_join(math, por, by= join_by, suffix= c(".math", ".por"))
colnames(innerjoin_math_por)
str(innerjoin_math_por)
dim(innerjoin_math_por)

alc <- select(innerjoin_math_por, one_of(join_by))

notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]


for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(innerjoin_math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

glimpse(alc)

#Create alcohol usage + hgh alcohol usage to alcohol consumption data
library(ggplot2)
alc <- mutate(alc, alc_use= (Dalc + Walc)/2)
alc <- mutate(alc, high_use = (alc_use) > 2)

glimpse (alc)

write.table(alc,file="alc.txt")

