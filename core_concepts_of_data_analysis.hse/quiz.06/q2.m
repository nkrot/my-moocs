# Question 2
# ==========
# Vizualization of the data.
#
# Take the same data and standardize by subtracting the feature means and, afterwards, dividing the features by their ranges.
# Norm the two first principal components to the square roots of the corresponding singular values.
# What are the first and the second loading vectors?
#
# Question 3:
# ===========
# Output the total contribution of the 2D data model of Question 2 to the data scatter, per cent.
# Output one floating number without % sign. The answer format is xx.xxxx, for example, 11.1234.
#

nc_age = 4
nc_se  = 6 
nc_oop = 7
nc_ci  = 8

# fake data
#X = [
#		41 66 90;
#		57 56 60;
#		61 72 79;
#		69 73 72;
#		63 52 88;
#		62 83 80
#]

all_data = load("../DATASETS/studn.dat");
X = all_data(:, [nc_age, nc_se, nc_oop, nc_ci]);

R = max(X) - min(X);         # feature range
X_norm = (X - mean(X)) ./ R; # normalized

[Z, Mu, C] = svd(X_norm);

mu1 = Mu(1,1);
#z1 = Z(:,1) * sqrt(mu1) # oops. this is not called PCA in this task :)
c1 = C(:,1) * sqrt(mu1) * -1
# c1: YES !!!
#  -1.081085
#   0.063209
#   1.079367
#   0.998479

mu2 = Mu(2,2);
#z2 = Z(:,2) * sqrt(mu2) # oops. this is not called PCA in this task
c2 = C(:,2) * sqrt(mu2) * -1
#c2: YES !!!
#   0.88437
#   1.21965
#   0.15947
#   0.70793

#
# answers given in the quiz
#
#The first loading vector is (-0.5920, 0.0346, 0.5910, 0.5468)
#The second loading vector is (0.5289, 0.7294, 0.0954, 0.4233)

#The first loading vector is (-1.081, 0.0632, 1.0794, 0.9984)
#The second loading vector is (0.9656, 1.3312, 0.1741, 0.7730)

#The first loading vector is (10.0543, 17.8887, 19.0649, 17.2950)
#The second loading vector is (-14.8873, -21.0641, 15.1772, 13.7115)

# ++++ YES !!!
#The first loading vector is (-1.081, 0.0632, 1.0794, 0.9985 )
#The second loading vector is (0.8843, 1.2196, 0.1595, 0.7079) 

######################################################################
# question 3

#z1 = Z(:,1) * sqrt(mu1)
#z2 = Z(:,2) * sqrt(mu2)
#plot(z1, z2, 'k.')

# data scatter
ds = sum(sum(X_norm.^2))

# the proportion of the variance taken into account
p = 100 * (mu1^2 + mu2^2) / ds #=> 72.115 YES!
# alternatively
contrib1 = 100 * mu1^2 / ds
contrib2 = 100 * mu2^2 / ds
total_contrib = contrib1 + contrib2 #=> 72.115 YES!

