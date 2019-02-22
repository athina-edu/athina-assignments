# DEFAULT CODE TO GET YOU STARTED
library(igraph)

# Set of employees
employees <-
  c("Pablo",
    "Lee",
    "Georgia",
    "Vincent",
    "Andy",
    "Frida",
    "Joan",
    "Claude")

# This is the set of movies
movies <-
  c(
    "The Shawshank Redemption",
    "Forrest Gump",
    "The Matrix",
    "Anaconda",
    "The Social Network",
    "The Godfather",
    "Monty Python and the Holy Grail",
    "Snakes on a Plane",
    "Kung Fu Panda",
    "The Dark Knight",
    "Mean Girls"
  )

# QUESTION 1
# Using igraph, load in the bipartite graph from employee_movie_choices and return that graph
# This function should return a igraph graph with 19 nodes and 24 edges
question1 <- function() {
  # YOUR CODE HERE

}

# QUESTION 2
# Using the graph from the previous question (by utilizing your function),
# add nodes attributes named 'type' where movies have the value 'movie'
# and employees have the value 'employee' and return that graph.
# This function should return an igraph graph with node attributes {'type': 'movie'} or {'type': 'employee'}

question2 <- function() {
  # YOUR CODE HERE

}

# QUESTION 3
# Build a weighted projection of the graph from the previous function which tells us
# how many movies different pairs of employees have in common. In other words, we return the weighted graph
# of employees only and represent the edges as weights derived by the common movies.
# See more: http://igraph.org/r/doc/bipartite_projection.html
# You will have to make $type values compatible with what the function needs. There is another function that can
# do this for you or you can run your own code.
# This function should return a weighted projected graph.

question3 <- function() {
  # YOUR CODE HERE

}


# QUESTION 4
# Suppose you'd like to find out if people that have a high relationship score also like the same types of movies.
# Find the Pearson correlation ( using cor() ) between employee relationship scores (Employee_Relationships.txt)
# and the number of movies
# they have in common. If two employees have no movies in common it should be treated as a 0, not a missing value,
# and should be included in the correlation calculation.
# Use your previous function to make things easier for yourself.
# This function should return a float.

question4 <- function() {
  # YOUR CODE HERE

}

# QUESTION 5
# Plot the graph derived from question3() using the circle layout.
# Edge width should be determined by the edge's weight times 2 (for visibility purposes).
# Everything else leave as default.
# The function should return the layout of nodes based on a circular layout
# You should be able to notice that
# there is an inverse relationship between edge weight and node degree. Andy
# tends to watch a large variety of movies whereas most people watch many movies
# that are common to their peers.

question5 <- function() {
  set.seed(25)
  # YOUR CODE HERE

}
