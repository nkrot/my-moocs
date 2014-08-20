function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%


#Y = 5x4
#
#   5   4   0   0
#   3   0   0   0
#   4   0   0   0
#   3   0   0   0
#   3   0   0   0
#
#R = 5x4
#
#   1   1   0   0
#   1   0   0   0
#   1   0   0   0
#   1   0   0   0
#   1   0   0   0

predictions = X * Theta' - Y;   # prediction difference on all movies
predictions = predictions .* R; # set to 0 predictions on the movies that the used did not rate

J = sum(sumsq(predictions)) / 2;

debug = 0;
if debug == 1
  printf("Y:\n");
  size(Y)
  Y

  printf("R:\n");
  size(R)
  R

#  printf("X:\n");
#  size(X)
#  X

  printf("Theta:\n");
  size(Theta)
  Theta
end

X_grad = predictions * Theta;
Theta_grad = predictions' * X; 

if debug == 1
#  printf("X_grad:\n");
#  size(X_grad)
#  X_grad
  printf("Theta_grad:\n");
  size(Theta_grad)
  Theta_grad
end

#
# regularization
#

J += 0.5*lambda*sum(sumsq(Theta)) + 0.5*lambda*sum(sumsq(X));

X_grad += (lambda * X);
Theta_grad += (lambda * Theta);

% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
