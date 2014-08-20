function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


#printf("Size of Theta1:\n"); size(Theta1) # 25x401
#printf("Size of Theta2:\n"); size(Theta2) # 10x26
#printf("Size of y:\n");      size(y)      # 5000

#OK#J = nnCostFunction_with_loop(X, y, Theta1, Theta2, num_labels);
#printf("J in non-vectorized: %f\n", J);

J = nnCostFunction_vectorized(X, y, Theta1, Theta2, num_labels);
#printf("J in vectorized: %f\n", J);

reg = (sum(sumsq(Theta1(:,2:end))) + sum(sumsq(Theta2(:,2:end)))) * lambda / (2*m);

J += reg;

[Theta1_grad, Theta2_grad] = compute_gradients(X, y, Theta1, Theta2, num_labels, lambda);

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end

######################################################################
# Grad1 - gradient for Theta1
# Grad2 - gradient for Theta2

function [Delta1, Delta2] = compute_gradients(X, all_y, Theta1, Theta2, num_labels, lambda)

  Delta1 = zeros(size(Theta1));
  Delta2 = zeros(size(Theta2));

  m = size(X, 1);

  # for each sample
  for i = 1:m
	#
	# compute predictions at all inner and final layers
	#
	# input layer
	a1 = [1; X(i,:)'];
	# hidden layer
#	z2 = Theta1 * a1;
	a2 = [1; sigmoid(Theta1 * a1)];
	# output layer
	a3 = sigmoid(Theta2 * a2);

	# [0 0 0 1 0 0 0 0 0 0] if expected label is "4"
	y = 1:num_labels == all_y(i); 

	#
	# compute deltas - amount of error on each layer
	#
	d3 = (a3' - y);
	# a2 = 26x1
	# d3 = 1x10
	Delta2 += (a2 * d3)'; # 26x10

	d2 = d3 * Theta2 .* (a2 .* (1 - a2))'; # 1x26 TODO: use sigmoidGradient(z)
	d2 = d2(2:end); # get rid of bias unit
	# a1 = 401x1
	# d2 = 1x25 (bias unit removed)
	Delta1 += (a1 * d2)';
#	size(Delta1)
  end

  Delta1 = Delta1 / m;
  Delta2 = Delta2 / m;

  #
  # regularization
  #
  reg_theta1 = Theta1 * lambda/m;
  reg_theta1(:,1) = 0;
  Delta1 += reg_theta1;

  reg_theta2 = Theta2 * lambda/m;
  reg_theta2(:,1) = 0;
  Delta2 += reg_theta2;
end

######################################################################

function J = nnCostFunction_vectorized(X, y, Theta1, Theta2, num_labels)
  m = size(X, 1);
  J = 0;

  h = nn_predict(X, Theta1, Theta2); #=> 5000x10
#  printf("Size of matrix with all predictions:", size(h));

#  h(5000,:)

  # represent each value in y as a vector of 10 values, where 1 occurs
  # in the column corresponding to the expected label (digit) and all
  # the rest are 0.
  # For example, if y is [1,1,3,2] then
  # [ 1 0 0 0 0 0 0 0 0 0 ]
  # [ 1 0 0 0 0 0 0 0 0 0 ]
  # [ 0 0 1 0 0 0 0 0 0 0 ]
  # [ 0 1 0 0 0 0 0 0 0 0 ]
  # TODO: in octave 3.6.0+ it can be accomplished using broadcasting:
  #   repmat(1:10, length(y), 1) == y
  Y = zeros(size(h));

  for i = 1:size(y,1)
	Y(i,y(i)) = 1;
  end

#  Y(10,:)
#  Y(599,:)
#  Y(2000,:)
#  (1-Y)(2000,:) # ok

  J = (sum(sum(Y .* log(h))) + sum(sum((1-Y) .* log(1-h)))) / -m;
end

######################################################################
# compute the matrix of predictions for all samples
# Return:
#  5000x10 matrix
#
# Predictions for the 1st sample
#  1.1266e-04
#  1.7413e-03
#  2.5270e-03
#  1.8403e-05
#  9.3626e-03
#  3.9927e-03
#  5.5152e-03
#  4.0147e-04
#  6.4807e-03
#  9.9573e-01

function h = nn_predict(X, Theta1, Theta2)
  h = [0];

  # add bias unit
  X = [ones(size(X,1),1), X]; #=> 5000x410

  #
  # hidden layer
  #
  A1 = sigmoid(X * Theta1'); # 5000x25
#  printf("size of A1\n"); size(A1)

  # add bias unit
  A1 = [ones(size(A1,1),1), A1];

  #
  # output layer
  #
  h = sigmoid(A1 * Theta2'); #=> 5000x10
#  printf("size of h\n"); size(h)

#  h(1,:)(:) # show predictions for the first sample
end

######################################################################
# ok, works correctly

function J = nnCostFunction_with_loop(X, y, Theta1, Theta2, num_labels)

  m = size(X, 1);
  J = 0;

  for i=1:size(X,1)
#	printf("Sample #%i, expected label: %i\n", i, y(i));

	# h -- all predictions for a single data sample, 1..10
	h = nn_predict_single_sample(X(i,:), Theta1, Theta2);
#  h

#	if i == 5000
#	  h
#	end

	# expected result as a vector (sy -- single sample y):
	# for the label "0" it will be
	#  ex: [0 0 0 0 0 0 0 0 0 1]
	# for the label "5" it will be
	#  ex: [0 0 0 0 1 0 0 0 0 0]
	k = y(i);
	sy = zeros(1,num_labels);
	sy(k) = 1; 

	J += sy * log(h) + (1-sy) * log(1-h);
  end

  J /= -m;
end


######################################################################
# oh, shit! 0 * -Inf = -Inf !!!

#function p = multiply(a, b)
#  p = 0;
#  for j = 1:size(a,2)
#	_p = a(j)*b(j);
#	p += _p;
#	printf("%i * %i = %i\n", a(j), b(j), _p);
#  end
#  printf("Product=%i", p);
#end

######################################################################
#
# for a single sample x, it returns predictions with respect to all labels.
# These numbers are probabilities of sample being each label (real predictions for the 1st sample):
#   1.1266e-04   <-- probability of being label "1"
#   1.7413e-03   <-- probability of being label "2"
#   2.5270e-03
#   1.8403e-05
#   9.3626e-03
#   3.9927e-03
#   5.5152e-03
#   4.0147e-04
#   6.4807e-03
#   9.9573e-01   <-- probability of being label "10" (that is 0)

function h = nn_predict_single_sample(x, Theta1, Theta2)

#  h = zeros(size(x));

  #
  # input layer
  #
  x = [1 x]; # add bias unit

  #
  # hidden layer
  #
  a1 = sigmoid(Theta1 * x'); # compute activation parameters
#  a1

  a1 = [1; a1];     # add bias unit
#  printf("Size of a1:\n"); size(a1)

  #
  # output layer
  #
  h = Theta2 * a1;  #
#  printf("Size of h:\n"); size(h)
#  printf("h="); h

  h = sigmoid(h);
#  h
end

######################################################################
