# Assume a 1000-string data set with a binary output feature.
# Assume a classification tree on the set with 4 terminal nodes.
# Consider the following contingency table between the partition and the output feature.
#
#      Yes  | No  | Total
# S1     80    20 |  100
# S2     50   450 |  500
# S3    100   200 |  300
# S4     70    30 |  100
# ----------------------
# Total 300   700   1000
#
# What is the accuracy of each of the Yes and No decisions?
# Output two numbers, separated by a space.

clear;

figures = [
		   80,   20;
		   50,  450;
		   100, 200;
		   70,  30
]

tp = 80 + 70;
tn = 450 + 200;
fp = 50 + 100;
fn = 20 + 30;

total = sum(sum(figures));

# incorrect: 0.8
#accuracy_of_yes = (tp + tn) / total
# incorrect: 0.18
#accuracy_of_no  = (fp + fn) / total

accuracy_of_yes = tp / (tp+fp) # 150/300
#accuracy_of_no  = fp / (fn+fp) # crap!
accuracy_of_no  = tn / (fn+tn) # 650/700

# correct: 0.50
precision = tp / (tp+fp)

# incorrect: 0.8333
recall = tp / (tp+fn)
