
# Task:
# Run the following commands to create a data frame in R with measurements for 30 men describing their height in centimeters, weight in kilograms, and a logical indicator for whether they have a daughter or not. 
# Subset the data frame to only the individuals that are greater than 188 centimeters tall. Assign this subset to a data frame called dataFrameSubset. Then run this command: mean(dataFrameSubset$weightsK) to get the average weight among this subset of men in the data. What is the value that is produced? 

set.seed(31);

heightsCM   = rnorm(30, mean=188, sd=5);
weightsK    = rnorm(30, mean=84,  sd=3); 
hasDaughter = sample(c(TRUE,FALSE), size=30, replace=T); 
dataFrame   = data.frame(heightsCM, weightsK, hasDaughter);

dataFrameSubset = dataFrame[heightsCM>188, ]

print(mean(dataFrameSubset$weightsK))


