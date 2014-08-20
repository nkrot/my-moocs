#
# custom panel function
# on random data
# see ex_02.R

set.seed(10)
x = rnorm(100)
f = rep(0:1, each = 50)
y = x + f - f * x + rnorm(100, sd=0.5)

# give names to each unique value of f
f = factor(f, labels = c("Group 1", "Group 2"))

# custom panel function
# in each panel a scatterplot and a regression line will be shown
xyplot(y ~ x | f, panel = function(x,y,...) {
  panel.xyplot(x, y, ...) # first, call the default panel function for 'xyplot'
  panel.lmline(x, y, col=2) # regression line, in red color
})
