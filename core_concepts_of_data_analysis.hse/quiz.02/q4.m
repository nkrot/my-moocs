# The standard deviation of Y is 2.
# The standard deviation of X is 4.
# The correlation coefficient between X and Y is 0.8.
# What is the value of the slope in the linear regression equation Y=aX+b.
#
# SLOPE = a

# sigma = standard deviation
std_y = 2 # sigma(y)
std_x = 4 # sigma(x)
rho = 0.8

a = rho * std_y / std_x
#a = 0.8 * 2 / 4 = 0.8 * 0.5 = 0.40

