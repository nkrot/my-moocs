function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%


h = X * theta;

#printf("Hello1\n");
J = (sumsq(h - y) + lambda * sumsq(theta(2:end,:))) / (2*m);

#printf("Hello2\n");
grad = sum(repmat((h - y), 1, length(theta)) .* X)/m;

#printf("Hello3\n");
reg = lambda * theta / m;
reg(1) = 0; # we dont want to regularize theta0

grad = grad' + reg;

% =========================================================================

grad = grad(:);

#printf("goodbye ");
end
