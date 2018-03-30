


#------------------------------Control Structures-------------------------------


# * if, else: testing a condition
# * for: execute a loop a fixed number of times
# * while: execute a loop while a condition is true
# * repeat: execute an infinite loop
# * break: break the execution of a loop
# * next: skip an iteration of a loop
# * return: exit a function


# if

	if(x > 3) {
		y <- 10
	} else {
		y <- 0
	}

	y <- if(x > 3) {
		10
	} else {
		0
	}

# for

# for loops take an iterator variable and assigns it
# successive values from a sequence or vector.
# For loops are most commonly used fro iterating over the elements of an object

	for(i in 1:10) {
		print(i)
	}

	x <- c("a", "b", "c", "d")

	for(i in 1:4) {
		print(x[i])
	}

	for(i in seq_along(x)) {
		print(x[i])
	}

	for(letter in x) {
		print(letter)
	}

	for(i in 1:4) print(x[i])


# Nested for loops


	x <- matrix(1:6, 2, 3)

	for(i in seq_len(nrow(x))) {
		for(j in seq_len(ncol(x))) {
			print(x[i])
		}
	}

	# while

		count <- 0
		while(count < 10) {
			print(count)
			count <- count + 1
		}

		z <- 5

		while(z >= 3 && z<= 10) {
			print(z)
			coin <- rbinom(1, 1, 0.5)

			if(coin == 1) { ## random walk
				z <- z + 1
			} else {
				z <- z - 1
			}
		}



	# repeat
	#
	#
	# repeat initiates an infinite loop; these are not commonly used in
	# statistical applications but they do have their uses.
 	# The only way to exit a repeat loops is to call break.

		x0 <- 1
		tol <- 1e-8

		repeat {
			x1 <- computeEstimate()

			if(abs(x1 - x0) < tot) {
				break
			} else {
				x0 <- x1
			}
		}


	# next, return

	# next is used to skip an iteration of a loop

		for(i in 1:100) {
			if(i <=20) {
				## Skip the first 20 iterations
				next
			}
			## Do something here
		}

	# return signals that a function should exit and return a given value.


#---------------------------functions-------------------------------------------


# In addition to not specifying a default value,
# you can also set an argument to NULL.

	f <- function(a, b = 1, c = 2, d = NULL) {

	}

# Lazy Evaluation
#
#
# Arguments to functions are evaluated lazily,
# so they are evaluated only as needed.

	f <- function(a, b) {
		a^2
	}
	f(2)

	## [1] 4

	f <- function(a, b) {
		print(a)
		print(b)
	}
	f(45)

	## [1] 45

	## Error: argument "b" is missing, with no default


# The '…' Argument
#
#
# The … argument indicate a variable number of arguments that are
# usually passed on to other functions.
#
# … is often used when extending another function and you
# don't want to copy the entire argument list of the original function

	myplot <- function(x, y, type = "l", …) {
		plot(x, y, type = type, …)
	}

# Generic functions use … so that extra arguments can be passed to methods.

	mean
	function(x, …)
	UseMethod("mean")

# The … is also necessary when the number of arguments passed to the
# function cannot be known in advance.

	args(paste)
	function(…, sep = " ", collapse = NULL)

	args(cat)
	function(…, file = "", sep = " " , fill = FALSE,
		labels = NULL, append = FALSE)

	> args(paste)
	function(…, sep=" ", collapse = NULL)

	> paste("a", "b", sep = ":")
	[1] "a:b"

	> paste("a", "b", se = ":")
	[1] "a b :"

#-----------------------Vectorized Operations-----------------------------------

		> x <- 1:4; y <- 6:9
		> x + y
		[1]  7  9 11 13
		> x > 2
		[1] FALSE FALSE  TRUE  TRUE
		> x >= 2
		[1] FALSE  TRUE  TRUE  TRUE
		> y == 8
		[1] FALSE FALSE  TRUE FALSE
		> x * y
		[1]  6 14 24 36
		> x / y
		[1] 0.1666667 0.2857143 0.3750000 0.4444444

		> x <- matrix(1:4, 2, 2); y <= matrix(rep(10, 4), 2, 2)
		> x * y		## element-wise multiplication
		     [,1] [,2]
		[1,]   10   30
		[2,]   20   40
		> x / y
		     [,1] [,2]
		[1,]  0.1  0.3
		[2,]  0.2  0.4
		> x %*% y 		## true matrix multiplication
		     [,1] [,2]
		[1,]   40   40
		[2,]   60   60


#-------------------------Dates in R--------------------------------------------


		#
		# Dates are represented by the Date and can be coerced
		# from a character string using the as.Date() function.

			x <- as.Date("1970-01-01")
			x
			## [1] "1970-01-01"
			unclass(x)
			## [1] 0
			unclass(as.Date("1970-01-02"))
			## [1] 1


		# Times in R
		#
		# Times are represented using the POSIXct or the POSIXlt class.
		#
		# * POSIXct is just a very large integer under the hood;
		# it uses a useful class when you want to store times in
		# something like a data frame
		# * POSIXlt is a list underneath and it stores a bunch of other
		# useful information like the day of the week, day of the
		# year, month, day of the month
		#
		# There are a number of generic functions that work on the dates and times.
		#
		# * weekdays: give the day of the week
		# * months: give the month name
		# * quarters: give the quarter number("Q1", "Q2", "Q3", "Q4")
		#
		# Times can be coerced from a character string using the
		# as.POSIXlt or as.POSIXct function.

			> x <- Sys,time()
			x
			## [1] "2013-01-24 22:04:14 EST"
			p <- as POSIXlt(x)
			names(unclass℗
			## [1] "sec" "min" "hour" "mday" "mon"
			## [6] "year" "wday" "yday" "isdst"
			p$sec
			## [1] 14.34

		# you can also use the POSIXct format:

			x <- Sys.time()
			x ## Already in `POSIXct` format
			## [1] "2013-01-24 22:04:14 EST"
			unclass(x)
			## [1] 1359083054
			x$sec
			## Error: $ operator is invalid for atomic vectors
			p <- as.POSIXlt(x)
			p$sec
			## [1] 14.37

		# Finally there is the strptime function in case your dates are
		# written in a different format.

			datestring <- c("January 10, 2012 10:40", "December 9, 2011")
			x <- strptime(datestring, "%B %d, %Y %H:%M")
			x
			## [1] "2012-01-10 10:40:00" "2011-12-09 09:10:00"
			class(x)
			## [1] "POSIXlt" "POSIXt"

		# Operations on Dates and Times


		# You can use mathematical operations on dates and times.
		# Well really just + and -. you can do comparisons too (_i.e._ ==, <=)

			x <- as.Date("2012-01-01")
			y <- strptime("9 January 2011 11:34:21", "%d %b %Y %H:%M:%S")
			x-y
			## Warning: Incompatible methods ("-.Date",)
			## "-.POSIXt") for "-"
			## Error: non-numeric argument to binary operator
			x <- as.POSIXlt(x)
			x-y
			## Time difference of 356.3 days

		# Even keep track of leap years, leap seconds, daylight savings,
		# and time zones.

			x <- as.Date("2012-03-01"); y <- as.Date("2012-02-28")
			x-y
			## Time difference of 2 days
			x <- as.POSIXct("2012-10-25 01:00:00")
			y <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT")
			y-x
			## Time difference of 1 hours















#end
