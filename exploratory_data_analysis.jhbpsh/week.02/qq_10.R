#
# The following code creates a scatterplot of 'votes' and 'rating' from the movies dataset
# in the ggplot2 package.
# After loading the ggplot2 package with the library() function, I can run
#  > qplot(votes, rating, data = movies)
#
# How can I modify the the code above to add a smoother to the scatterplot?

# description of movies data frame
#str(movies)

# option 1 -- ANSWER
# this is the only method that shows a statistic (a summary of data, in form of a line
# which is called a smoother)
qplot(votes, rating, data = movies) + geom_smooth()

# option 2
#qplot(votes, rating, data = movies, panel = panel.loess)

# option 3 -- not runnable
# ERROR: can not find stats_smooth function
#qplot(votes, rating, data = movies) + stats_smooth("loess")

# option 4
# the graph looks similar to option 2
#qplot(votes, rating, data = movies, smooth = "loess")
