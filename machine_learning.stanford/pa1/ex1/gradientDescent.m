function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
  % GRADIENTDESCENT Performs gradient descent to learn theta
  %   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
  %   taking num_iters gradient steps with learning rate alpha

  % Initialize some useful values
  m = length(y); % number of training examples
  J_history = zeros(num_iters, 1);

  for iter = 1:num_iters

	% ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %

	h = X * theta; # hypotheses
	hyx = X' * (h - y);
	# => [-566.40; -6336.90]
	# these are two sums, one for the 1st feature (1st column in X)
	# and the other for the 2nd feature (the 2nd column in X),
	# each one for all data points

	delta = alpha/m * hyx; # the derivatives for thetas
#	delta

	# the same as delta
#	shit(1,:) = alpha / m * sum( (h-y).*X(:,1) );
#	shit(2,:) = alpha / m * sum( (h-y).*X(:,2) );
#	shit

	# similtaneously update all thetas
	theta = theta - delta;

    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

#	J_history(iter) # inspect to make sure J decreases
	end

end
