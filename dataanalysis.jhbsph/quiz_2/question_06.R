# Use the data from Question 3.
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products.
#  ACR, class 3: 10+ acres
#  AGS, sales of agricultural products, class 6.
# Assign that logical vector to the variable agricultureLogical.
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. 
#    which(agricultureLogical)
# What are the first 3 values that result? 

data <- read.csv("ss06hid.csv")

agricultureLogical <- data$ACR == 3 & data$AGS == 6

print(which(agricultureLogical)) #=> 125 238 262 470 ...

# yes
#print(data[c(125,238,262), c("ACR","AGS")])

