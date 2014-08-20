# week 7
#
# Consider the Iris dataset features as related to a hidden factor, the flower size, find this hidden factor as represented by the first principal component
# and rescale its values, so that the maximum size is 100 and the minimum is zero.
# No normalization of original features is required.
# Output the value of the factor at Iris specimen numbers 3, 15, 150.
#
# Output three numbers: z1, z2, z3. Do not put "%" sign after the numbers.
# Separate numbers by spaces.
# Do not separate numbers by commas or semicolons.
# For every correct number z1, z2, z3 you get 0.66 out of 2.0.
# After the soft deadlines these scores are halved.
# All problems allow to make a default error of 0.001 in all decimal answers unless otherwise stated.
# It is enough to use 4 digits after the point.
#
# The test input test dataset below consists of every tenth entity from original Iris dataset.
# The test output contains the value of the factor at Iris specimen numbers 5, 10, 15.
#
clear;

# SAMPLE DATA
# expected values on sample_fixed.dat dataset
filename = "sample_fixed.dat"
indices = [5,10,15];
sample_output = [3.7059 43.8576 86.9379];

# REAL DATA
filename = "real_fixed.dat"
indices = [3,15,150];

######################################################################

# the last column is taxon ID
data = load(filename);

X = data(:, 1:4); # all except taxon id

[Z, Mu, C] = svd(X);

z = Z(:,1) * -1; # PCA
c = C(:,1) * -1;
mu = Mu(1,1);

#
# rescale z (PCA) to be 0..100 scale
#

# this approach is not applicable here
#alpha = 100 / sum(c * 100)
#z_rescaled = X * c * alpha
#z_rescaled(indices,1)

# substract minimal value and normalize to the range max-min
z_rescaled = (z - min(z)) ./ (max(z) - min(z)) * 100
answer = z_rescaled(indices,1)

#sample_output - answer' # close to 0

# answer: -- CORRECT
#    8.1511
#   25.8883
#   58.1794

