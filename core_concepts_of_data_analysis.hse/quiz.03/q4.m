# Consider the following contingency table between Occupation and Activity statuses.
# see activity.dat
# Compute Quetelet indexes for all entries.
# Find chi-squared for the table as the summary Quetelet index.

activities = load("activity.dat")

act_sums = sum(activities, 2) # all columns in a row summed up
status_sums = sum(activities) # all rows in a colum summed up

activity_probs = act_sums ./ sum(act_sums)
activity_cond_probs = activities ./ status_sums

status_probs = status_sums ./ sum(status_sums)

probs = activities ./ sum(act_sums)

# quetelet indices
# quetelet = (p(activity_i|status_j) - p(activity_i)) / p(activity_i)
quetelets = (activity_cond_probs - activity_probs) ./ activity_probs

# summary quetelet index A
# is a sum of all quetelet indices weighted by their probabilities
# alternatively: inner product of two tables: cooccurrence and quetelets
# NOTE: this is the correct answer to the Q4
Q = sum(sum(quetelets ./ probs))

# questin 5 of the quiz
# =====================
# Find chi^2 as a summary quetelet index
  # (see slide 42, where r = pn)
pn = (activity_probs * status_probs)
d = probs - pn;
dd = d .* d;
chi = dd ./ pn;

chi2 = sum(sum(chi)) # chi2 =  0.16891 -- CORRECT!
