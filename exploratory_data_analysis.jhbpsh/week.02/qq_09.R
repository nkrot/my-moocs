#
# When I run the following code I get an error:
# I was expecting a scatterplot of 'votes' and 'rating' to appear. What's the problem?
#
# 1) ggplot does not yet know what type of layer to add to the plot. -- ANSWER?
# 2) There is a syntax error in the call to ggplot.
# 3) The object 'g' does not have a print method.
# 4) The dataset is too large and hence cannot be plotted to the screen.

library(ggplot2)

# the dataset movies is available in ggplot2 package
g <- ggplot(movies, aes(votes, rating))
print(g)

# error message is:
#No layers in plot
