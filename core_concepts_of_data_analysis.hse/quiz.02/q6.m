# Two features, X and Y, are presented in the table below.
# Find the coefficients of the linear regression equation Y=aX+b, the correlation coefficient and the determinacy coefficient.
# Estimate the value of Y at an object with X=1.5.
# Output in the following order: a, b, the correlation coefficient, the estimated value of Y.
# (There must be four numbers separated by spaces.) 

q6 = load("q6.dat");

x = q6(:,1)
mean_x = mean(x)

y = q6(:,2)
mean_y = mean(y)

printf "Correlation coefficient "
rho = corr(x,y)

# a = rho * sigma(y) / sigma(x), where sigma is std
printf("Coefficient ")
a = rho * std(y) / std(x)

# b = mean(y) - a * mean(x)
printf("Coefficient ")
b = mean(y) - a * mean(x)

printf("Determinancy coefficient ")
rho_squared = rho * rho

#std(y) * std(y)

printf "Y at x=1.5"
est_y = a * 1.5 + b

#printf("Answer: %f %f %f %f\n", a, b, rho, est_y); # bad!!
printf "Answer "
a, b, rho, est_y

# 1.5000 3.2000 1.00000 5.4500

