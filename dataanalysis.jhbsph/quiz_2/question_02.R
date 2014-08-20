#
# Open a connection to the old version of my blog: http://simplystatistics.tumblr.com/ , read the first 150 lines of the file and assign them to a vector simplyStats. Apply the nchar() function to simplyStats to count the characters in each element of simplyStats. How many characters long are the lines 2, 45, and 122?
#

con <- url("http://simplystatistics.tumblr.com/", "r")
simplyStats <- readLines(con, 150)
sizes <- nchar(simplyStats)

print("Sizes of all items (lines)")
print(sizes)

print("Sizes of lines 2, 45, 122")
print(sizes[c(2,45,122)]) #=> 918, 5, 24

close(con)

