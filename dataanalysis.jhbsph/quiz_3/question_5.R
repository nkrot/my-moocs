# Load the hand-written digits data using the following commands:
#
# library(ElemStatLearn)
# data(zip.train)
# 
# Each row of the zip.train data set corresponds to a hand written digit.
# The first column of the zip.train data is the actual digit.
# The next 256 columns are the intensity values for an image of the digit.
# To visualize the adigit we can use the zip2image() function to convert a row into a 16 x 16 matrix: 
# >Create an image matrix for the 3rd row, which is a 4
# >im = zip2image(zip.train,3)
# >image(im)
#
# Using the zip2image file, create an image matrix for the 8th and 18th rows.
# For each image matrix calculate the svd of the matrix (with no scaling).
# What is the percent variance explained by the first singular vector for the image from the 8th row?
#  => ~98 %
# What is the percent variance explained for the image from the 18th row?
#  => ~48%
# Why is the percent variance lower for the image from the 18th row?
#
# Answers:
# 1) The first singular vector explains 99% of the variance for row 8 and 44% for row 18.
#    The reason the first singular vector explains less variance for the 18th row is that the image is more complicated, so there are multiple patterns each explaining a larger percentage of variance.
# 2) The first singular vector explains 98% of the variance for row 8 and 48% for row 18.
#    The reason the first singular vector explains less variance for the 18th row is because the 8th row has higher average values.
# 3) The first singular vector explains 98% of the variance for row 8 and 48% for row 18.
#    The reason the first singular vector explains less variance for the 18th row is because the image can be represented by two circles, which require less variance to explain.
# 4) [+] The first singular vector explains 98% of the variance for row 8 and 48% for row 18.
#    The reason the first singular vector explains less variance for the 18th row is that the image is more complicated, so there are multiple patterns each explaining a large percentage of variance.

# install.packages("ElemStatLearn")
library(ElemStatLearn)
data(zip.train)

#im = zip2image(zip.train,3)
#image(im)

par(mfrow=c(1,4))

im8 = zip2image(zip.train,8)
image(im8)

svd8 = svd(im8)
plot(svd8$d^2/sum(svd8$d^2),pch=19,xlab="Singluar vector",ylab="Variance explained")

im18 = zip2image(zip.train,18)
image(im18)
svd18 = svd(im18)
plot(svd18$d^2/sum(svd18$d^2),pch=19,xlab="Singluar vector",ylab="Variance explained")
