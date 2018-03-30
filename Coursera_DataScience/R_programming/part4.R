# The str() Function
#
#
# Compactly display the internal structure of an R object.
#
# * A diagnostic function and an alternative to 'summary'
# * It is especially ell suited to compactly display the ( abbreviated)
#  contents of (possibly nested) lists
# * Roughly one line per basic object

# str() answers the question: what's in an object?


# Functions

	> str(str)
	function (object, ...)

	> str(lm)
	function (formula, data, subset, weights, na.action, method = "qr", model = TRUE,
	    x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, contrasts = NULL,
	    offset, ...)

	> str(ls)
	function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE,
	    pattern)


# Vectors


	> x <-rnorm(100, 2, 4)
	> summary(x)
	   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
	 -8.647  -0.632   1.874   2.215   4.839  13.450
	> str(x)
	 num [1:100] 0.9986 -6.5211 3.4636 0.5328 0.0474 ...


# Factors


	> f <-gl(40, 10)
	> str(f)
	 Factor w/ 40 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
	> summary(f)
	 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
	10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
	27 28 29 30 31 32 33 34 35 36 37 38 39 40
	10 10 10 10 10 10 10 10 10 10 10 10 10 10


# Data Frames

	> library(datasets)
	> head(airquality)
	  Ozone Solar.R Wind Temp Month Day
	1    41     190  7.4   67     5   1
	2    36     118  8.0   72     5   2
	3    12     149 12.6   74     5   3
	4    18     313 11.5   62     5   4
	5    NA      NA 14.3   56     5   5
	6    28      NA 14.9   66     5   6
	> str(airquality)
	'data.frame':	153 obs. of  6 variables:
	 $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
	 $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
	 $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
	 $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
	 $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
	 $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...


# Matrix

	> m <- matrix(rnorm(100), 10, 10)
	> str(m)
	 num [1:10, 1:10] 1.201 0.712 -0.118 -0.581 -0.467 ...
	> m[, 1]
	 [1]  1.2012138  0.7118305 -0.1178031 -0.5812110 -0.4673343 -0.5950841
	 [7]  0.4184978  1.8155424 -1.6733037 -0.7371094


# Lists


	> s <- split(airquality, airquality$Month)
	> str(s)


  # Generating Random Numbers
	#
	#
  # Functions for probabilty distributions in R.
	#
  # * rnorm(): generate random Normal variates with a given mean and
	# 	standard deviation
  # * dnorm(): evaluate the Normal probability density (with a given mean/SD)
	# 	at a point (or vector of points)
  # * pnorm(): evaluate the cumulative distribution function for
	# 	a Normal distribution
  # * rpois(): generate random Poisson variates with a given rate

  # Working with the Normal distribution requires using these foud functions

  	dnorm(x, mean = 0, sd = 1, log = FALSE)
  	pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
  	qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, loq.p = FALSE)
  	rnorm(n, mean = 0, sd = 1)

  # If phi is the cumulative distribution function for a standard
	# 	Normal distribution, then pnorm(q) = phi(q) and qnorm = (phi^-1) * p.

  	> x <- rnorm(10)
  	> x
  	 [1]  0.14830698 -0.27440203 -0.40556516  0.50068503 -0.95326642 -0.63328362
  	 [7] -0.81992345 -0.09771788  1.51245542 -0.15558700
  	> x <- rnorm(10, 20, 2)
  	> x
  	 [1] 20.11975 19.63171 19.52337 17.29754 21.20785 21.60996 22.59994 22.64028
  	 [9] 22.38124 19.43176
  	> summary(x)
  	   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
  	  17.30   19.55   20.66   20.64   22.19   22.64

  Setting the random number seed with set.seed ensures reproducibility.

  	> set.seed(1)
  	> rnorm(5)
  	[1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078
  	> rnorm(5)
  	[1] -0.8204684  0.4874291  0.7383247  0.5757814 -0.3053884
  	> set.seed(1)
  	> rnorm(5)
  	[1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078



  # Generate Posson data:

  	> rpois(10, 1)
  	 [1] 0 0 1 1 2 1 1 4 1 2
  	> rpois(10, 2)
  	 [1] 4 1 2 0 1 1 0 1 4 1
  	> rpois(10, 20)
  	 [1] 19 19 24 23 22 24 23 20 11 22
  	> ppois(2, 2)
  	[1] 0.6766764
  	> ppois(4, 2)
  	[1] 0.947347
  	> ppois(6, 2)
  	[1] 0.9954662


    # Generating Random Numbers from a Linear Model
    # ---------------------------------------------

    # Suppose we want to simulate from the following linear model

    	> set.seed(20)
    	> x <- rnorm(100)
    	> e <- rnorm(100, 0, 2)
    	> y <- 0.5 + 2 * x + e
    	> summary(y)
    	   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
    	-6.4080 -1.5400  0.6789  0.6893  2.9300  6.5050
    	> plot(x, y)


    # What if x is binary?

    	> set.seed(10)
    	> x <- rbinom(100, 1, 0.5)
    	> e <- rnorm(100, 0, 2)
    	> y <- 0.5 + 2 * x + e
    	> summary(y)
    	   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
    	-3.4940 -0.1409  1.5770  1.4320  2.8400  6.9410
    	> plot(x, y)


    # Suppose we want to simulate from a Poisson model

    	> set.seed(1)
    	> x <- rnorm(100)
    	> log.mu <- 0.5 + 0.3 * x
    	> y <- rpois(100, exp(log.mu))
    	> summary(y)
    	   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
    	   0.00    1.00    1.00    1.55    2.00    6.00
    	> plot(x, y)

    ![Poisson Distribution](img/lecture-03-poisson-distribution.png?raw=true)

    # Random Sampling
    # ---------------

    #The sample function draws randomly from a specified set of (scalar)
		#objects allowing you to sample from arbitrary distributions.

    	> set.seed(1)
    	> sample(1:10, 4)
    	[1] 3 4 5 7
    	> sample(1:10, 4)
    	[1] 3 9 8 5
    	> sample(letters, 5)
    	[1] "q" "b" "e" "x" "p"
    	> sample(1:10)
    	 [1]  4  7 10  6  9  2  8  3  1  5
    	> sample(1:10)
    	 [1]  2  3  4  1  9  5 10  8  6  7
    	> sample(1:10, replace = TRUE)
    	 [1] 2 9 7 8 2 8 5 9 7 8
