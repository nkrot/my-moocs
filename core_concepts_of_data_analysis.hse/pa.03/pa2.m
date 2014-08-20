# Find the coefficients of linear regression Y = aX + b of the petal length Y and petal width X (features 3 and 4 respectively) as well as the determinacy coefficient between them.
#
# Output three float numbers in the following order: a coefficient, b coefficient, determency coefficient.
#
# All problems allow to make a default error of 0.001 in all decimal answers unless otherwise stated.
#
# Sample Input:
# 4.3	3.0	1.1	0.1	I.setosa
# 7.7	3.0	6.1	2.3	I.virginica
#
# Sample Output:
#
# 2.272727 0.872727 1.000000
#
# my computed values (match!) over test.dat:
# a =  2.2727
# b =  0.87273
# rho_squared =  1.00000
#
# computed (correct!) values on the real dataset:
# a =  2.2749
# b =  1.0720
# rho_squared =  0.91788
#

#data = load("test.dat")
data = load("real.dat");
x = data(:,4);
y = data(:,3);

printf "Correlation coefficient "
rho = corr(x,y)

printf "Determinancy coefficient "
rho_squared = rho * rho

printf("Coefficient ")
a = rho * std(y) / std(x)

printf("Coefficient ")
b = mean(y) - a * mean(x)

printf "Answers to submit "
a
b
rho_squared
