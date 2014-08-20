# Is this true that if a data matrix is centered
#  (that is, for each column, its mean value is subtracted from all the column components)
# then the sum of its elements is 0?
#
# Options
# 1) Yes -- my answer
# 2) No
#

clear;

a = [10 22 31 40 5 10 10 198]

m = mean(a) 

centered = a - m

sum(centered)



