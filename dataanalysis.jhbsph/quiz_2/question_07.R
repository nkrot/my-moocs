# Question 7
# Use the data from Question 3.
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products.
# Assign that logical vector to the variable agricultureLogical.
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE and assign it to the variable indexes.
#    indexes =  which(agricultureLogical)
# If your data frame for the complete data is called dataFrame you can create a data frame with only the above subset with the command: 
#    subsetDataFrame  = dataFrame[indexes,] 
# Note that we are subsetting this way because the NA values in the variables will cause problems if you subset directly with the logical statement.
# How many households in the subsetDataFrame have a missing value for the mortgage status (MRGX) variable?

data <- read.csv("ss06hid.csv")

agricultureLogical <- data$ACR == 3 & data$AGS == 6

indices =  which(agricultureLogical)

#print(indices)

subset <- data[indices,]

print("How many households in the subsetDataFrame have a missing value for the mortgage status (MRGX) variable?")
print(sum(is.na(subset$MRGX)))
# => 8

# alternatively, use MRGX in subsetting
print(sum(data$ACR == 3 & data$AGS == 6 & is.na(data$MRGX), na.rm=T))
# => 8


