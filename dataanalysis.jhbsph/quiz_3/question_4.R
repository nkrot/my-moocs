#
# Load the following data set into R using either the .rda or .csv file:
#
# https://spark-public.s3.amazonaws.com/dataanalysis/quiz3question4.rda
# https://spark-public.s3.amazonaws.com/dataanalysis/quiz3question4.csv 
#
# Make a scatterplot of the x versus y values. 
# How many clusters do you observe?
# Perform k-means clustering using your estimate as to the number of clusters.
# Color the scatterplot of the x, y values by what cluster they appear in.
# Is there anything wrong with the resulting cluster estimates? 
# Options
# 1) [-] There are two obvious clusters. Despite the wrapped clusters, the k-means algorithm converges to the correct clusters when you use multiple starts of the algorithm.
# 2) There are three obvious clusters. The k-means algorithm does not assign all of the points to the correct clusters because they wrap around each other.
# 3) =There are two obvious clusters. The k-means algorithm does not converge to a solution because the clusters wrap around each other.
# 4) There are two obvious clusters. The k-means algorithm does not assign all of the points to the correct clusters because the clusters wrap around each other. 
#
# Attempt 2
# 1) There is one obvious cluster. The k-means algorithm does not work because there is only one cluster in the data.
# 2) There are two obvious clusters. The k-means algorithm correctly assigns all points to the two obvious clusters.
# 3) [+] There are two obvious clusters. The k-means algorithm does not assign all of the points to the correct clusters because the clusters wrap around each other.
# 4) There are two obvious clusters. The k-means algorithm does not converge to a solution because the clusters wrap around each other.

outfile = "quiz3question4.csv"
#link = "https://spark-public.s3.amazonaws.com/dataanalysis/quiz3question4.csv"
#download.file(link, outfile, "curl")

data = read.csv(outfile)

par(mfrow=c(1,3))
plot(data$x, data$y, col="blue")

dataxy = data[,c(2,3)]

# all run produces the same plot
kmeansObj_2 = kmeans(dataxy, centers=2, iter.max=100)
plot(data$x, data$y, col=kmeansObj_2$cluster)
points(kmeansObj_2$centers, col=c(1,2,3), pch=3, lwd=2, cex=2)

kmeansObj_22 = kmeans(dataxy, centers=2, iter.max=100)
plot(data$x, data$y, col=kmeansObj_22$cluster)
points(kmeansObj_22$centers, col=c(1,2,3), pch=3, lwd=2, cex=2)

#kmeansObj_23 = kmeans(data, centers=2)
#plot(data$x, data$y, col=kmeansObj_23$cluster)


## plots are equal
#kmeansObj_3 = kmeans(data, centers=3)
#plot(data$x, data$y, col=kmeansObj_3$cluster)
#
#kmeansObj_32 = kmeans(data, centers=3)
#plot(data$x, data$y, col=kmeansObj_32$cluster)
#
#kmeansObj_33 = kmeans(data, centers=3)
#plot(data$x, data$y, col=kmeansObj_33$cluster)
