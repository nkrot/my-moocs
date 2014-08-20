# Take the Student data over Age, SE, OOP, CI (find the dataset in the Dataset section).
# Find the PCA hidden factor behind it.
# Norm the factor loadings to the square root of the maximum singular value.
# What are the resulting factor loadings?

clear;

# number of column corresponding to the category
nc_age = 4
nc_se  = 6 
nc_oop = 7
nc_ci  = 8

all_data = load("../DATASETS/studn.dat");

X = all_data(:, [nc_age, nc_se, nc_oop, nc_ci]);

[Z, Mu, C] = svd(X);

z = Z(:,1); # PCA
c = C(:,1); # loadings
mu = Mu(1,1) # maximum singular value

z = -1 * z;
c = -1 * c;

# this is the answer:
mu_normalized = c * sqrt(mu) # YES!
#   10.054
#   17.889
#   19.065
#   17.295


