# Let a hidden talent factor is built over three features so that the loading values for it are C’=(0.2673, 0.5345, 0.8018).
# A new student whose scores over the three features are f=(70,40,60) arrives.
# Assuming that the maximum singular value mu=35, could you derive her hidden factor score?
#
# Answers:
# 1) 2.87
# 2) 2.52 -- my answer
# 3) 14.9
# 4) 16.84

clear;

c = [0.2673; 0.5345; 0.8018]
mu = 35

new_scores = [70,40,60]

# week 7 slide 7:
# z = X * c / mu
new_scores * c / mu #=> 2.52

