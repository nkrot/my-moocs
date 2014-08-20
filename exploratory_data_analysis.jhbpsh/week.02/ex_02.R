#
# panel function
#
# on random data
set.seed(10)
x = rnorm(100)
#=> vector with 100 numbers, positive and negative

# generate a vector comprising numbers 0 and 1 each 50 times => vector of 100
f = rep(0:1, each = 50)
#f
#=>
#[1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#[50] 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#[99] 1 1

# 100 values of y
y = x + f - f * x + rnorm(100, sd=0.5)
#y

# scatter plot, 1 panel
#xyplot(y ~ x)

# scatter plot, two panels
#xyplot(y ~ x | f)

# the same as the above
#xyplot(y ~ x | f, layout = c(2,1))

# give names to each unique value of f
f = factor(f, labels = c("Group 1", "Group 2"))
# now each panel will have a name: Group 1, Group 2
#xyplot(y ~ x | f, layout = c(2,1))

# custom panel function
# like in the above but in each panel a horizontal line will be added showing the median
xyplot(y ~ x | f, panel = function(x,y,...) {
  panel.xyplot(x, y, ...) # first, call the default panel function for 'xyplot'
  panel.abline(h = median(y), lty = 2) # add horizontal line at y = median(y)
})

