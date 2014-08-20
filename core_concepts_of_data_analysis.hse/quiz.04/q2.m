#Estimate probabilities of the key words within A and B categories according to the bag-of-words model.
# 
#     drink | play | talent | woman
# A1 |  1    | 0    |  2     | 0
# A2 |  2    | 1    |  1     | 1
# B1 |  0    | 1    |  0     | 1
# B2 |  1    | 2    |  1     | 2
# B3 |  0    | 2    |  1     | 1
# B4 |  1    | 1    |  0     | 2
#
# Output eight numbers, separate them by spaces.
#
#
# Question 3
# For B1 article compute naïve Bayes decision rule scores for both A and B categories.
# Output two numbers, separated by a space.

clear;

multiplier = 100;

# the 1st column is the class
# class(A) = 1
# class(B) = 2
data = [
		1,    1, 0, 2, 0;
		1,    2, 1, 1, 1;
		2,    0, 1, 0, 1;
		2,    1, 2, 1, 2;
		2,    0, 2, 1, 1;
		2,    1, 1, 0, 2
];

for k=1:2;
  indices = find(data(:,1) == k);
  counts = sum(data(indices, 2:end)) .+ 1;
  word_probs(k,:) = counts ./ sum(counts);

  class_prior_probs(k) = log(multiplier * size(indices,1) / size(data,1));
end

class_prior_probs

# correct
printf("Answer to the question 2:\n")
word_probs

#
# Question 3
# For B1 article compute naïve Bayes decision rule scores for both A and B categories.
B1 = data(3, 2:end)
B4 = data(6, 2:end)
A1 = data(1, 2:end)

word_probs = log(word_probs .* multiplier)

# answer to q3 -- correct
printf("Answer to the question 3:\n")
scores_of_b1_given_class = word_probs * B1' + class_prior_probs'

# correct!
scores_of_a1_given_class = word_probs * A1' + class_prior_probs'

scores_of_b4_given_class = word_probs * B4' + class_prior_probs'
