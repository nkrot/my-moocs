# Consider a data table for 8 students and 2 features, as follows 
#
# Student 	Mark 	Occupation
#  1 		50 		IT
#  2 		75 		IT
#  3 		80 		IT
#  4 		60 		AN
#  5 		55 		AN
#  6 		40 		AN
#  7 		35 		AN
#  8 		50 		AN
# Envelop the data with fictional features corresponding to the categories.
# Standardize the data with the feature averages and ranges.
# Set K=2 and initial seeds of two clusters so that they should be as far from each other as possible.
# Complete a K-means process.
# Output the feature means.
#
#feature means = (55.6250, 0.3750, 0.6250)
#feature means = (4.5, 55.6250, 0.375)
#feature means = (52.5, 0, 1)
#feature means = (50.0, 0, 1) 
#
# Question 10
# ==========
# Consider the clusters that you achieved in Question 9. Choose the indices of entities that are the initial seeds.
# 1) 1 and 6
# 2) 2 and 5 -- my answer, based on mindist_sum
# 3) 4 and 7
# 4) 3 and 7 
#
# Question 11
# ===========
# Consider the clusters that you achieved in Question 9. Choose the numbers of elements in the final K-means clusters
# 1) 5 and 3
# 2) 2 and 6
# 3) 4 and 4
# 4) 3 and 5 -- my answer


clear;

data = [
		50, 1, 0;
		75, 1, 0;
		80, 1, 0;
		60, 0, 1;
		55, 0, 1;
		40, 0, 1;
		35, 0, 1;
		50, 0, 1
]

# the answer to Q9
# 55.62500    0.37500    0.62500
means = mean(data)

data_norm = (data - mean(data)) ./ (max(data) - min(data));

k = 2; # number of clusters

indices = [3,7] # of initial centers
#indices = [1,2]
#indices = [1,8]

# from Q10
#indices = [1, 6] # q2 =  0.058436; quality =  0.21852; mindist_sum =  4.4444
indices = [2, 5] # q2 =  0.058436; quality =  0.21852; mindist_sum =  2.8889
#indices = [4, 7] # q2 =  0.058436; quality =  0.21852; mindist_sum =  3.3704
#indices = [3, 7] # q2 =  0.058436; quality =  0.21852; mindist_sum =  4.4444

initial_centers = data_norm(indices, :)

[centers, mincenter, mindist, q2, quality] = kmeans(data_norm, initial_centers)

centers

mindist_sum = sum(mindist)


# indices = [3,7]
#centers =
#   0.28241   0.62500  -0.62500
#  -0.16944  -0.37500   0.37500

#indices = [1,2]
#centers =
#  -0.16944  -0.37500   0.37500
#   0.28241   0.62500  -0.62500

#indices = [1,8]
#centers =
#   0.28241   0.62500  -0.62500
#  -0.16944  -0.37500   0.37500

