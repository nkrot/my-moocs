# Use the data from Question 3.
# Apply strsplit() to split all the names of the data frame on the characters "wgtp".
# What is the value of the 123 element of the resulting list?

data <- read.csv("ss06hid.csv")

split_names <- strsplit(names(data), "wgtp")

print(split_names[123])
# => "" "15"


