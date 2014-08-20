function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%


#size(X)      # 5000x400
#size(Theta1) # 25x401
#size(Theta2) # 10x26

# add bias unit x0
X = [ones(m,1) X];

# output of the first layer
l1_predictions = sigmoid(X * Theta1');

# add bias unit x0
l1_predictions = [ones(m,1) l1_predictions];
#size(l1_predictions) #=> 5000x26

# output of the second layer
l2_predictions = sigmoid(l1_predictions * Theta2');

# select best values in each row. the position in the row corresponds
# to either digit "1", "2", "3" .. "10", where "10" means "0"
[mx, p] = max(l2_predictions, [], 2);





% =========================================================================


end
