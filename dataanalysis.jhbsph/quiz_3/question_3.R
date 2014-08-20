# Load the iris data into R using the following commands: 
#
# library(datasets)
# data(iris)
#
# Subset the iris data to the first four columns and call this matrix irisSubset. 
# Apply hierarchical clustering to the irisSubset data frame to cluster the rows.
# If I cut the dendrogram at a height of 3 how many clusters result?
# => 4

library(datasets)
data(iris)

# columns are coordinates, here there are 4 coordinates
irisSubset = iris[,1:4]

distances = dist(irisSubset)

hClustering = hclust(distances)

plot(hClustering)

