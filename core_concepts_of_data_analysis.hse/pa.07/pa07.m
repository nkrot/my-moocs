# week 8
#
# Standardize your Iris data by subtracting the feature means and dividing by feature ranges.
# Write or take a code for k-means and apply it to the standardized data.
# The number of clusters k is three and the initial centers are 1st, 51st and 101st objects (under the assumption that index counting starts from one).
# Output new centroids c1, c2, c3 of the clusters.
# Every centroid is a tuple of four numbers.
#
# Do not separate numbers by commas or semicolons.
# For every correct centroid c1, c2, c3 you get 0.66 out of 2.0.
# After the soft deadlines these scores are halved.
# All problems allow to make a default error of 0.001 in all decimal answers unless otherwise stated.
# It is enough to use 4 digits after the point.
# Test dataset below consists of every tenth entity from original Iris dataset.
# 1st, 6th and 11th objects were chosen as initial centers (under the assumption that index counting starts from one).

clear;

######################################################################
# test data

filename = "sample_fixed.dat" ;
indices = [1, 6, 11];

# sample output for K=3
sample_centers = [
	-0.2898,  0.2118, -0.4820, -0.4334;
	-0.2154, -0.4392,  0.0186, -0.0583;
	 0.2993,  0.03698, 0.3365,  0.3345
];

######################################################################
# real data

filename = "real_fixed.dat"
indices = [1, 51, 101];

######################################################################

k = 3; # number of clusters

data = load(filename);

X = data(:,1:4); # all except taxon ID in the last column

X_norm = (X - mean(X)) ./ (max(X) - min(X));

initial_centers = X_norm(indices, :);

# help for matlab
# https://www.princeton.edu/~kung/ele571/571-MatLab/571BP_Chad/kmeans.m
#[idx, centers] = kmeans(X_norm, k)
#
# looks like kmeans in Octave is an incomplete implementation
# and the following does not work
#[idx, centers] = kmeans(X_norm, k, 'emptyaction', 'Start', initial_centers)

# another implementation: http://cseweb.ucsd.edu/~elkan/fastkmeans.html
[centers, mincenter,mindist,q2,quality] = kmeans(X_norm, initial_centers);
#sample_centers - centers

centers

## plot the first two columns of the dataset
# crap??
#plot(X(idx==1,1), X(idx==1,2), 'ro')
#hold on
#plot(X(idx==2,1), X(idx==2,2), 'bs')
#plot(X(idx==3,1), X(idx==3,2), 'g^')
#
#plot (centers(1, 1), centers (1, 2), 'r+', 'markersize', 10);
#plot (centers(2, 1), centers (2, 2), 'b+', 'markersize', 10);
#plot (centers(3, 1), centers (3, 2), 'g+', 'markersize', 10);

#hold off



