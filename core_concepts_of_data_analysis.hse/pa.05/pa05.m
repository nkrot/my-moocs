#
# Consider the Iris dataset features as related to a hidden factor, the flower size, 
# find the hidden factor represented by the first principal component and output the feature loadings (vector C).
# Estimate the contribution of the principal component to the data scatter, per cent.
# No normalization of original features is required.
#
# Output five float numbers.
# First four values are components of vector C: c1, c2, c3, c4.
# The fifth value is the contribution value. Do not put "%" sign after the contribution value.
# Separate numbers by spaces. Do not separate numbers by commas or semicolons.
# Note, that all numbers should be positive.
# For every correct number from c1, c2, c3, c4 you get 0.3 out of 2.0 and 0.8 for the correct contribution value.
# After the soft deadlines these scores are halved.
# All problems allow to make a default error of 0.001 in all decimal answers unless otherwise stated.
# It is enough to use 4 digits after the point.
#
# Test dataset below consists of every tenth entity from original Iris dataset.
# Sample Input (see devel.txt and devel.dat):
# 5.1	3.5	1.4	0.1	I.setosa
# 5.4	3.7	1.5	0.2	I.setosa
# 5.4	3.4	1.7	0.2	I.setosa
# 4.8	3.1	1.6	0.2	I.setosa
# 5.0	3.5	1.3	0.3	I.setosa
# 7.0	3.2	4.7	1.4	I.versicolor
# 5.0	2.0	3.5	1.0	I.versicolor
# 5.9	3.2	4.8	1.8	I.versicolor
# 5.5	2.4	3.8	1.1	I.versicolor
# 5.5	2.6	4.4	1.2	I.versicolor
# 6.3	3.3	6.0	2.5	I.virginica
# 6.5	3.2	5.1	2.0	I.virginica
# 6.9	3.2	5.7	2.3	I.virginica
# 7.4	2.8	6.1	1.9	I.virginica
# 6.7	3.1	5.6	2.4	I.virginica
#
# Sample Output:
# 4.1458 2.1055 2.8513 0.9619 96.4547

clear;

#data = load("devel.dat");
data = load("real.dat");

X = data(:,1:4);
size(X)

#
# contribution
#

# data scatter
ds = sum(sum(X .* X));

[Z,Mu,C] = svd(X);

C(:,1);

best_mu = Mu(1,1); #=> 30.677

contribution = (100 * best_mu^2 / ds) #=> 96.455 YES!

# TODO: why this?
feature_loadings = sqrt(best_mu) * C(:,1) * -1 #=> correct!
