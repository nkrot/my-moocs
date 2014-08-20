function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

[_J, _grad] = costFunction(theta, X, y);

# and now add regularization term
# ignore the 1st theta
J = _J + 0.5 * lambda / m * sum(theta(2:size(theta)) .^ 2);
#J = _J + 0.5 * lambda / m * (theta(2:end)' * theta(2:end));
#printf("J before and after:\n");
#[_J, J]

grad_regs = lambda / m * theta';
grad_regs(1,1) = 0; # ignore the 1st theta

grad = _grad .+ grad_regs;

% =============================================================

end
