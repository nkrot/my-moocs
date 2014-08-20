function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

values = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
len = length(values);

# 64x3 matrix that will hold all tested values:
#  C, sigma, error
errors = zeros(len^2, 3);

for i=1:len
  for j=1:len
	c = values(i); # C
	s = values(j); # sigma

	# train the model
	model = svmTrain(X, y, c, @(x1, x2) gaussianKernel(x1, x2, s));
	# run the model on the cross-validation set
	predictions = svmPredict(model, Xval);
	# compute the error
	err = mean(double(predictions ~= yval));
	# store current C, sigma and corresponding error
	errors(((i-1)*len)+j,:) = [c, s, err];
#	printf("C=%f, sigma=%f, error=%f\n", c, s, err);
  end
end

#errors

[minval, minidx] = min(errors);
minrow = minidx(3);

# oops. the following does not work:
# [C sigma] = errors(minidx(3), 1:2)
C = errors(minrow, 1);       # best = 1
sigma = errors(minrow, 2);   # best = 0.1

% =========================================================================

end

#I store all related c, sigma and error in a matrix (64x3), filling one row at each iteration. And then find the row that contains the minimal value of the error using min() with two return parameters.
