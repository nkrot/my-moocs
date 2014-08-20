function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)
  % GRADIENTDESCENTMULTI Performs gradient descent to learn theta
  %   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
  %   taking num_iters gradient steps with learning rate alpha

  % Initialize some useful values
  m = length(y); % number of training examples
  J_history = zeros(num_iters, 1);

  [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters);

#   for iter = 1:num_iters

#     % ====================== YOUR CODE HERE ======================
#     % Instructions: Perform a single gradient step on the parameter vector
#     %               theta. 
#     %
#     % Hint: While debugging, it can be useful to print out the values
#     %       of the cost function (computeCostMulti) and gradient here.
#     %

# 	h = X * theta; # hypotheses
# 	hyx = X' * (h - y);
# 	# => [-566.40; -6336.90]
# 	# these are two sums, one for the 1st feature (1st column in X)
# 	# and the other for the 2nd feature (the 2nd column in X),
# 	# each one for all data points
# #	hyx

# 	delta = alpha/m * hyx; # the derivatives for thetas

# 	# similtaneously update all thetas
# 	theta = theta - delta;

#     % ============================================================

#     % Save the cost J in every iteration    
#     J_history(iter) = computeCostMulti(X, y, theta);
#   end

#    J_history
end
