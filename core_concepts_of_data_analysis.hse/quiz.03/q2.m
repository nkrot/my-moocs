#
# Find Quetelet index for females who spent 100$ each and express it per cent.
#
# my answer = 313 INCORRECT!

data = load("spendings.dat");
num_people = sum(sum(data))

gender_amount_probs = data ./ num_people

gender_probs = sum(data, 2) ./ num_people
amount_probs = sum(data) ./ num_people

# p(Gender|spent amount)
gender_conditioned_by_amount_probs = data ./ sum(data)

quetelets = (gender_conditioned_by_amount_probs - gender_probs) ./ gender_probs

# Q is a summary quetelet index
#Q = sum(sum(quetelets)) # bullshit, incorrect!

#weighted = quetelets ./ gender_amount_probs

# replace Inf with 0
#weighted(~isfinite(weighted)) = 0

#Q = sum(sum(weighted))

per_cent_quetelets = 100*quetelets
# post 185.714 as the new answer -- correct
# alternative way of computing:
#  Q=100*20/(20*35)-1=1.86


