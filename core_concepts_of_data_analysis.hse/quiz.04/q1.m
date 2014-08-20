# given the table: q1_data.orig
# What are naïve Bayes decision rule scores of X for each of the categories:
#  feminism (F), entertainment (E), household (H)?
# Output three numbers, separate them by spaces.

clear;

multiplier = 100; # used to get rid of negative logarithms

# class | article number in class | words ...
# where
#  class(F) = 1
#  class(E) = 2
#  class(H) = 3
#  class(X) = 4
data = load("q1.dat")

# compute prior probability of each of the three classes
#  p_prior(F)
#  p_prior(E)
#  p_prior(H)
for k = 1:3;
  counts(k) = size(find(data(:,1) == k), 1);
end

class_priors = log(counts .* multiplier ./ sum(counts))

# compute word probabilities in each class
# to get rid of zeroes, assume each word was seen at least once.
# this is accomplished by adding 1 to all word freqs
for k = 1:3;
  indices = find(data(:,1) == k);
  raw_word_counts = data(indices, 3:end); # part of the table that contains only word counts
                                          # for specific class

  word_counts = sum(raw_word_counts) .+ 1;

  c_words = sum(word_counts)

  # working with probabilities is best in logarithmic space.
  # and we want positive logarithms, so we multiply each value by 1000
  word_probs(k, :) = log(word_counts .* multiplier ./ c_words)
end

# compute conditional probabilities of X given all three classes
#  p(X|F)
#  p(X|E)
#  p(X|H)

# the query words X
X = data(find(data(:,1) == 4), 3:end)

#for k=1:3;
#  probs_x_given_class(k) = sum(word_probs(k,:) .* X);
#end

probs_x_given_class = word_probs * X'

# compute posterior probabilities of the classes given X (Bayes theorem)
#  p_post(F|X) = p(X|F) * p(F)
#  p_post(E|X) = p(X|E) * p(E)
#  p_post(H|X) = p(X|H) * p(H)
# use + as we are in a log space
# 

# answer for the Q1 is -- correct
class_posteriors = class_priors + probs_x_given_class'
