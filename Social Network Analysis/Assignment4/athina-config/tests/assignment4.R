# DEFAULT CODE TO GET YOU STARTED
# setwd("~/Dropbox/Courses/CSCI424/Assignment3/")
# setwd("C:/Users/tsike/Dropbox/Courses/CSCI424/Assignment4/")

# IMPORTANT: USE COMPLETE NAMESPACES SINCE WE ARE SWITCHING BETWEEN TWO MAJOR PACKAGES. E.G., igraph::sample_pa()


# PART 1
# For the first part of this assignment you will analyze randomly
# generated graphs and determine which algorithm created them.
# Construct a function that determines if a graph was generated based
# on one of the following algorithms:
# - Preferential Attachment ('PA')
#   Read further: https://en.wikipedia.org/wiki/Barab%C3%A1si%E2%80%93Albert_model#Node%20degree%20correlations
#   Also note this graph: https://en.wikipedia.org/wiki/Barab%C3%A1si%E2%80%93Albert_model#/media/File:Barabasi-albert_model_degree_distribution.svg
# - Small World with low probability of rewiring ('SW_L')
# - Small World with high probability of rewiring ('SW_H')
#   Read further: https://mathinsight.org/small_world_network
#   The properties of this networks are distinct and different from PA.
# In all cases you will have to identify the "ideal" thresholds and properties that identify each type of network.
# Examples of random graph generating functions:
library(igraph)
g1 <- igraph::sample_pa(100)
g2 <- igraph::sample_smallworld(1, 100, 5, 0.05)
g3 <- igraph::sample_smallworld(1, 100, 5, 0.8)

# The function should return a string: sample_pa or sample_smallworld_low or sample_smallworld_high

question1 <- function(g = g1) {
  # YOUR CODE HERE
 
}


# PART 2
# For the second part of the assignment you will be doing statical analysis of a
# social network of a monestary.
# Here is the backstory for your dataset:
# https://rdrr.io/cran/ergm/man/samplk.html
# You will be using the following:
library(statnet)
library(ergm)
data(samplk)
plot(samplk3)

# You will need to build ergm models to answer these questions.
# A source to read for this:
# https://statnet.org/trac/raw-attachment/wiki/Sunbelt2016/ergm_tutorial.html

# Build a function that answers as a vector the following questions:
# 1. What is the probability for an edge to be formed in this network (e.g., 0.20)
# 2. Since the network is directed, what is the probability for a mutual friendship among the monks (e.g., 0.20)
# 3. What is the probability that a relationship between monks occurs based on the same group? (e.g., 0.20)
# 4. What is the probability for edge formation for monks belonging to the Turk group? (e.g., 0.20)
# 5. Does coming from the cloisterville monestary prior lead to relationship formation among these monks? Provide the p value instead. (e.g., 0.20)

# Note: NA is an acceptable answer
# Hint: you will need to separate ergm models for this function.

question2 <- function() {
  # YOUR CODE HERE
 
}
