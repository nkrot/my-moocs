# On a sample of 500 individuals, there was found that 200 of them are male, 100 of them go jogging and 50 are male who go jogging.
# How much this last figure differs from the value corresponding to the case at which the gender and jogging are statistically independent?
#

data = load("jogging.dat")

gender_sums = sum(data, 2)
jogging_sums = sum(data)

num_people = sum(gender_sums)

gender_probs = gender_sums ./ num_people
jogging_probs = jogging_sums ./ num_people

gender_jogging_probs = data ./ num_people

# incorrect! 
# my answer is -0.02
#independent_if_all_zero = (gender_probs .* jogging_probs) - gender_jogging_probs

# my answer is 0.02 -- INCORRECT
#independent_if_all_zero = gender_jogging_probs - (gender_probs .* jogging_probs)

# If gender and jogging are independent features, then the expected value of jogging people is like this:
alt_joggers = (gender_probs .* jogging_probs) .* 500

# the difference between expected joggers and real joggers is
# CORRECT ANSWER: 50-40 = 10
diff = data - alt_joggers
