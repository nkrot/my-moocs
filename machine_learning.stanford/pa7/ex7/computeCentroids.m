function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returs the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

#centroids
#size(X)
#X

for k=1:K
#  printf("cluster #%i of %i\n", k, K);
  points = X(idx == k,:);

#  switch k
#	case 1
#	  marker = 'k+'
#	case 2
#	  marker = 'ro'
#	otherwise
#	  marker = 'b*'
#  end
#
#  plot(centroids(k,:), marker, 'MarkerFaceColor', 'y', 'MarkerSize',10);
#  hold on;
#  plot(points, marker, 'MarkerSize', 3);

  centroids(k,:) = mean(points);
end






% =============================================================


end

