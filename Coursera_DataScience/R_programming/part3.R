
#------------------------loop functions-----------------------------------------


#-----------------------------lapply()------------------------------------------

# 1. A list x (if x is not a list it will be coerced to a list using as.list)
# 2. A function (or name of a function) FUN
# 3. Other arguments via its … argument

# lapply() always returns a list, regardless of the class of the input.

	> x < list(a = 1:5, b = rnorm(10))
	> lapply(x, mean)
	$a
	[1] 3

	$b
	[1] 0.0296824


	> x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
	> lapply(x, mean)
	$a
	[1] 2.5

	$b
	[1] 0.6082667

	$c
	[1] 1.467083

	$d
	[1] 5.074749


	> x <- 1:4
	> lapply(x, runif)
	[[1]]
	[1] 0.2675082

	[[2]]
	[1] 0.2186453 0.5167968

	[[3]]
	[1] 0.2689506 0.1811683 0.5185761

	[[4]]
	[1] 0.5627829 0.1291569 0.2563676 0.7179353


	> x <- 1:4
	> lapply(x, runif, min = 0, max = 10)
	[[1]]
	[1] 2.7815

	[[2]]
	[1] 3.90933223 0.03094193

	[[3]]
	[1] 5.307777 8.944883 1.933448

	[[4]]
	[1] 2.6599025 0.5341006 8.7176168 3.2705339

# lapply() and friends make heavy use of anonymous functions.

	> x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
	> x
	$a
	     [,1] [,2]
	[1,]    1    3
	[2,]    2    4

	$b
	     [,1] [,2]
	[1,]    1    4
	[2,]    2    5
	[3,]    3    6

# An anonymous function for extracting the first column of each matrix:

	> lapply(x, function(elt) elt[,1])
	$a
	[1] 1 2

	$b
	[1] 1 2 3

#---------------------------------sapply()--------------------------------------

# sapply() will try to simplify the result of lapply if possible

# * If the result is a list where every element is length 1,
  # then a vector is returned
# * IF the result i a list where every element is a vector of the same
  # length (> 1), a matrix is returned
# * If it can't figure things out, a list is returned

# Here's the lapply() behavior again:

	> x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
	> lapply(x, mean)
	$a
	[1] 2.5

	$b
	[1] -0.21178

	$c
	[1] 1.073342

	$d
	[1] 5.050767

	> sapply(x, mean)
	        a         b         c         d
 	2.500000 -0.211780  1.073342  5.050767


  # apply()
  #
  # apply() is used to evaluate a function (often an anonymous one)
  # over the margins of an array
  #
  # * It is most often used to apply a function to the rows or columns of a matrix
  # * It can be used with general array _e.g._
  #   taking the average of an array of matrices
  # * It is not only faster than writing a loop, but it works in one line!


  	str(apply)
  	function (X, MARGIN, …)

  # Arguments:
  #
  # * X is an array
  # * MARGIN is an integer vector indicating which margins should be "retained"
  # * FUN is a function to be applied
  # * … is for other arguments to be passed to FUN

  	> x <- matrix(rnorm(200), 20, 10)
  	> apply(x, 2, mean)

  	> apply(x, 1, sum)


  # For sums and means of matrix dimensions, we have some shortcuts.
  #
  # * rowSums = apply(x, 1, sum)
  # * rowMeans = apply(x, 1, mean)
  # * colMeans = apply(x, 2, sum)
  # * colMeans = apply(x, 2, mean)
  #
  # The shortcut functions are _much_ faster,
  # but you won't notice unless you're using a large matrix.


  # Other ways to apply
  #
  # Quantiles of the rows of a matrix.

  	> x <- matrix(rnorm(200), 20, 10)
  	> apply(x, 1, quantile, probs = c(0.25, 0.75))


  # Average matrix in an array

  	> a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
  	> apply(a, c(1, 2), mean)
  	            [,1]       [,2]
  	[1,]  0.04107431 0.64450175
  	[2,] -0.04269955 0.07289623
  	> rowMeans(a, dims = 2)
  	            [,1]       [,2]
  	[1,]  0.04107431 0.64450175
  	[2,] -0.04269955 0.07289623


#-------------------------------tapply()----------------------------------------

    # tapply() is used to apply a function over subsets of a vector.
    #
    # 	> str(tapply)
    # 	function (X, INDEX, FUN = NULL, ..., simplify = TRUE)

    # Arguments:
    #
    # * X is a vector
    # * INDEX is a factor or list of factors
    # * FUN is a function to be applied
    # * … contains other arguments to be passed to FUN
    # * simplify, should we simplify the result?


    	> x <- c(rnorm(10), runif(10), rnorm(10, 1))
    	> f <- gl(3, 10)
    	> f
    	 [1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3
    	Levels: 1 2 3
    	> tapply(x, f, mean)
    	        1         2         3
    	0.4102277 0.6013687 0.7498127

    # Take group means without simplification.

    	> tapply(x, f, mean, simplify = FALSE)
    	$`1`
    	[1] 0.4102277

    	$`2`
    	[1] 0.6013687

    	$`3`
    	[1] 0.7498127

    # Find group ranges.

    	> tapply(x, f, range)
    	$`1`
    	[1] -2.378255  2.673336

    	$`2`
    	[1] 0.1150650 0.9278384

    	$`3`
    	[1] -0.2201542  1.5680852


#-----------------------------split()-------------------------------------------

  # split takes a vector or other objects and splits it
  # into groups determined by a factor or a list of factors.
  #
  # 	> str(split)
  #     	function (x, f, drop = FALSE, …)
  #           Arguments:
  #     * x is a vector (or list) or data frame
  #     * f is a factor (or coerced to one) or a list of factors
  #     * drop indicates whether empty factor levels should be dropped


   x <- c(rnorm(10), runif(10), rnorm(10, 1))
       f <- gl(3, 10)
       split(x, f)

   lapply(split(x, f), mean)



# Splitting a Data Frame

   library(datasets)
       head(airquality)
       Ozone Solar.R Wind Temp Month Day
          41     190  7.4   67     5   1
          36     118  8.0   72     5   2
          12     149 12.6   74     5   3
          18     313 11.5   62     5   4
          NA      NA 14.3   56     5   5
          28      NA 14.9   66     5   6

   s <- split(airquality, airquality$Month)
       lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
      `5`
        Ozone  Solar.R     Wind
           NA       NA 11.62258

  `6`
         Ozone   Solar.R      Wind
            NA 190.16667  10.26667

  `7`
          Ozone    Solar.R       Wind
             NA 216.483871   8.941935

  `8`
        Ozone  Solar.R     Wind
           NA       NA 8.793548

  `9`
        Ozone  Solar.R     Wind
           NA 167.4333  10.1800

  # You can also use sapply() here.

   sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
                    5         6          7        8        9
      zone         NA        NA         NA       NA       NA
      olar.R       NA 190.16667 216.483871       NA 167.4333
      ind    11.62258  10.26667   8.941935 8.793548  10.1800

  # Remove NAs

   sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm  = TRUE))
                     5         6          7          8         9
      zone    23.61538  29.44444  59.115385  59.961538  31.44828
      olar.R 181.29630 190.16667 216.483871 171.857143 167.43333
      ind     11.62258  10.26667   8.941935   8.793548  10.18000


# Splitting on More than One Level


 x <- rnorm(10)
       f1 <- gl(2, 5)
       f2 <- gl(5, 2)
       f1
      [1] 1 1 1 1 1 2 2 2 2 2
      evels: 1 2
       f2
      [1] 1 1 2 2 3 3 4 4 5 5
      evels: 1 2 3 4 5
       interaction(f1, f2)
      [1] 1.1 1.1 1.2 1.2 1.3 2.3 2.4 2.4 2.5 2.5
      evels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 2.4 1.5 2.5

  # Interactions can create empty levels.

   str(split(x, list(f1, f2)))

  # Use drop = TRUE to get rid of empty levels.

   str(split(x, list(f1, f2), drop = TRUE))


  # ---------------------------mapply()-----------------------------------------

    # apply() is a multivariate apply of sorts which applies a function
  # in parallel over a set of arguments.
  #
  # 	> str(mapply)
  # 	function (FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE,
  # 	          USE.NAMES = TRUE)
  #
  # Arguments:
  #
  # * FUN is a function to apply
  # * … contains arguments to apply over
  # * MoreArgs is a list of other arguments to FUN
  # * SIMPLIFY indicates whether the result should be simplified

  list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))

   mapply(rep, 1:4, 4:1)
      [[1]]
      [1] 1 1 1 1

  [[2]]
      [1] 2 2 2

  [[3]]
      [1] 3 3

  [[4]]
      [1] 4

  # Vectorizing a function

   # Define a custom function:

  > noise <- function(n, mean, sd) {
      + rnorm(n, mean, sd)
      + }
      > noise(5, 1, 2)
      [1] 1.9218170  1.3781843 -0.5607748  3.7576328
      [5] 0.2590522
      > noise(1:5, 1:5, 2)
      [1] 1.780955 1.813852 1.827005 1.144564
      [5] 1.842238

   # Passing lists to this function does not behave as expected.

  > mapply(noise, 1:5, 1:5, 2)
      [[1]]
      [1] 2.2496

  [[2]]
      [1] 3.003979 3.621779

  [[3]]
      [1] 2.304840 4.135399 3.633926

  [[4]]
      [1] 1.269779 4.212011 2.963119 4.499524

  [[5]]
      [1] 5.353751 8.353743 6.389625 1.016071 3.344346

   # Which is the same as:

  > list(noise(1, 1, 2), noise(2, 2, 2),
           noise(3, 3, 2), noise(4, 4, 2),
           noise(5, 5, 2))





















  #end
