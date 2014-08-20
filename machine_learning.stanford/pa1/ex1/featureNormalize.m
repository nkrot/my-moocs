function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly
X_norm = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       

#X(1:3,:)

mu = mean(X);
sigma = std(X);

#mu
#sigma

# apply mu and sigma to each cell
#for col=1:size(mu,2)
#  X_norm(:,col) = (X(:,col) - mu(:,col)) / sigma(:,col);
#end
#X_norm(1:3,:)

# alternatively, convert mu and sigma to 47x2 matrices and
# apply element-wise subtraction and division
nrows = size(X,1); #=>47 rows
X_norm = (X - repmat(mu, nrows, 1)) ./ repmat(sigma,nrows,1);
#X_norm(1:3,:)

% ============================================================

end
