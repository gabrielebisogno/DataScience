

#Fixing character vectors: tolower(), toupper()

if(!file.exists("data")) {
  dir.create("data")
}
fileUrl <-
"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
if(!file.exists("./data/cameras.csv")) {
  download.file(fileUrl, destfile="./data/cameras.csv", method="curl")
}

cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
## [1] "address"      "direction"    "street"       "crossStreet"
## [5] "intersection" "Location.1"
tolower(names(cameraData))
## [1] "address"      "direction"    "street"       "crossstreet"
## [5] "intersection" "location.1"

splitNames = strsplit(names(cameraData), split = "\\.")
splitNames[[5]]
## [1] "intersection"
splitNames[[6]]  # 'Location.1' changed into two values, 'Location' and '1'
## [1] "Location" "1"


mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
## $letters
## [1] "A" "b" "c"
##
## $numbers
## [1] 1 2 3
##
## [[3]]
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    6   11   16   21
## [2,]    2    7   12   17   22
## [3,]    3    8   13   18   23
## [4,]    4    9   14   19   24
## [5,]    5   10   15   20   25

mylist[1]  # returns a list
## $letters
## [1] "A" "b" "c"
class(mylist[1])
## [1] "list"
mylist$letters  # returns a vector
## [1] "A" "b" "c"
class(mylist$letters)
## [1] "character"
mylist[[1]]  # returns a vector
## [1] "A" "b" "c"
class(mylist[[1]])
## [1] "character"

# Fixing character vectors: sapply
# Applies a function to each element in a vector or list
# Important parameters: x, FUN
splitNames[[6]][1]  #splitNames[[6]] contains two values, 'Location' and '1'; this returns the first
## [1] "Location"
firstElement <- function(x) {
    x[1]
}  # returns first element of x
sapply(splitNames, firstElement)  # passes each element in splitNames into firstElement
## [1] "address"      "direction"    "street"       "crossStreet"
## [5] "intersection" "Location"


if (!file.exists("./data")) {
    dir.create("./data")
}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
if (!file.exists("./data/reviews.csv")) {
    download.file(fileUrl1, destfile = "./data/reviews.csv", method = "curl")
}
if (!file.exists("./data/solutions.csv")) {
    download.file(fileUrl2, destfile = "./data/solutions.csv", method = "curl")
}
reviews = read.csv("./data/reviews.csv")
solutions = read.csv("./data/solutions.csv")
head(reviews, 2)
##   id solution_id reviewer_id      start       stop time_left accept
## 1  1           3          27 1304095698 1304095758      1754      1
## 2  2           4          22 1304095188 1304095206      2306      1
head(solutions, 2)
##   id problem_id subject_id      start       stop time_left answer
## 1  1        156         29 1304095119 1304095169      2343      B
## 2  2        269         25 1304095119 1304095183      2329      C

# Fixing character vectors: sub
# Important parameters: pattern, replacement, x
# Removes all underscores:

names(reviews)
## [1] "id"          "solution_id" "reviewer_id" "start"       "stop"
## [6] "time_left"   "accept"
sub(pattern = "_", replacement = "", x = names(reviews))
## [1] "id"         "solutionid" "reviewerid" "start"      "stop"
## [6] "timeleft"   "accept"

# Fixing character vectors: gsub
# sub replaces only the first match
# gsub (“global” sub) replaces all matches
testName <- "this_is_a_test"
sub("_", "", testName)
## [1] "thisis_a_test"
gsub("_", "", testName)
## [1] "thisisatest"


# Finding values: grep, grepl
# grep returns indices of elements in a data set that match a pattern
# grepl returns an array of TRUE/FALSE values for all elements in a data, TRUE=match

grep(pattern = "Alameda", x = cameraData$intersection)  # Find all intersections that contain 'Alameda'
## [1]  4  5 36
table(grepl(pattern = "Alameda", x = cameraData$intersection))  # build a table of intersections that do, and do not, contain 'Alameda'
##
## FALSE  TRUE
##    77     3
cameraData2 <- cameraData[!grepl(pattern = "Alameda", x = cameraData$intersection),
    ]  # subset of intersections that do not contain 'Alameda'

grep(pattern = "Alameda", x = cameraData$intersection, value = TRUE)  # value=TRUE means return the values, rather than indices to the original data set
## [1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"
## [3] "Harford \n & The Alameda"
grep("JeffStreet", cameraData$intersection)  # if no matches, returns intger(0)
## integer(0)
length(grep("JeffStreet", cameraData$intersection))  # returns 0
## [1] 0


library(stringr)
nchar("Jeffrey Leek")
## [1] 12
substr("Jeffrey Leek", 1, 7)
## [1] "Jeffrey"
paste("Jeffrey", "Leek")  # sep defaults to ' '
## [1] "Jeffrey Leek"
paste0("Jeffrey", "Leek")  # there is no sep param, just concatenates
## [1] "JeffreyLeek"
str_trim("Jeff      ")  # trims trailing whitespace
## [1] "Jeff"
str_trim("           Jeff        ", side = "both")  # or on both sides (can be left, right, both)
## [1] "Jeff"


#------------------------Regular expressions------------------------------------

# The ^ metacharacter means “start of line”

$ #represents the end of a line

# Character classes with []
# We can list a set of characters we will accept at
# a given point in the match.
#
#
# The following (which defines four consecutive character classes) will match
# “bush” in any combination of upper and lower case.
[Bb][Uu][Ss][Hh]
# You can combine metacharacters.
#
# The following matches either “i am” or “I am”,
# so long as it is at the start of a line:
^[Ii] am
# So this would match “i am”, “I am”, and “i amped”, at the start of a line.
#
#
# Similarly, you can specify a range of letters a-z or A-Z;
^[0-9][a-zA-Z]
# will match any single numeric digit, followed by any single letter,
# upper or lower case, at the start of a line.
#
# When used at the beginning of a character class,
# the ^ is also a metacharacter and indicates characters
# that should not be matched.
# [^?.]$
# will match any lines that do not end in either a question mark or a period.
#
# Also note that ^ has this functionality only at the the beginning of
# a character class. This:
# [a-z^]
# matches any lower case letter or the ^ symbol.
#
# More metacharacters
# “.” is used to refer to any character.
9.11
# matches a “9” followed by any character, followed by “11”.
#
# The “|” character is used to create “or” conditions in
# order to combine subexpressions:
#
#
flood|fire
# this matches either “flood” or “fire”.
# We can include any number of alternatives:
flood|earthquake|hurricane|coldfire
# The alternatives can also be more complex expressions:
# ^[Gg]ood|[Bb]ad
# The above matches either:
# “Good” or “good” at the start of a line
# “Bad” or “bad” anywhere in a line
# So the | takes precedence over the ,
# kind of like a * taking precedence over a + in math.
# If you wanted to match either “Good” or “good” or “Bad” or “bad” at
#  the start of a line, group both expressions in parentheses:
# ^([Gg]ood|[Bb]ad)
# The question mark indicates that the indicated expression is optional.
#
#
# The following matches “George Bush”, “george bush”, “George W. Bush”,
# “george w. bush”.
# So it will match with or without a “ W.” between “George” and “Bush”.
[Gg]eorge( [Ww]\.)? [Bb]ush
#

#------------------------Quantificators-----------------------------------------
# More metacharacters:
* and +
# The * metacharacter means "any number of the preceding character/expression”,
# and + means “one or more of the preceding character/expression”.
# (.*)
# will match any line that has both a left and right parens, whether there is any text between them or not.
# \(.*\)
# [0-9]+
# will match any string that has at least one numeric digit, and this:
# [0-9]+ (.*)[0-9]+
# will match any line that has one or more digits, followed by a space, followed by zero or more of any character, followed by one or more digits.
#
# More metacharacters:
{ and }
# These metacharacters are used to define the minimum and maximum number of matches of an expression. For example this:
#
[Bb]ush( +[^ ]+ +){1,5} debate
# looks for the following, in order:
#
# Either “Bush” or “bush”
# The following, from 1 to 5 times:
# one or more spaces
# one or more characters that are anything but a space
# one or more spaces
# “ debate”
# So in a sense, it looks for “Bush”, then one to five words, then “debate”
# (note that this is not an entirely accurate desription, one of those “words” might be an ellipse, “…”, and this hints at the difficulties you can face with regular experssions. Did I mention is't an art?)
#
# If you use {3} in the above, it means match exactly three times. If you use {2,7} it means match between 2 and 7 times. If you use {3,} it means match at least three times.
#
#
([a-zA-Z]+) \1
# will match any sequence of one or more letters that is repeated and separated by a space. In effect this says, “match any sequence of letters and store it as backreference 1, then a space, then whatever is stored as backreference 1”.

 #-------------------------“Greedy”_matches-------------------------------------
#
# The * metacharacter is “greedy” by default, so this:
#
^s(.*)s
# will match as many characters as possible after the “s” at the beginning of a line. For example, if the string searched is “soon as pass” then it will not match “soon as”, but rather, “soon as pass”. It will match as many characters as it possibly can.
#
# What if you want to match starting with an s, then any characters, but up to and including only the second s in the line? Do this:
#
^s(.*?)s
# The question mark directly after the asterisk is another special metacharacter that signals that non-greedy matching should be performed. So the command now is, “look for s at the start of a line, then zero or more characters followed by an s, but stop at the second s in the line”.
