# DEFAULT CODE TO GET YOU STARTED
library(igraph)

# In this assignment you will go through the process of importing and analyzing
# an internal email communication network between employees of a mid-sized
# manufacturing company. Each node represents an employee and each directed edge
# between two nodes represents an individual email. The left node represents the
# sender and the right node represents the recipient.

# QUESTION 1
# Using igraph, load up the directed multigraph from
# email_network.txt. Make sure the node names are strings.
# This function should return a directed igraph graph.

question1 <- function() {
  # YOUR CODE HERE

}

# QUESTION 2
# How many employees and emails are represented in the graph from Question 1?
# This function should return a tuple (#employees, #emails).

question2 <- function() {
  # YOUR CODE HERE

}

# QUESTION 3
# Part 1. Assume that information in this company can only be exchanged through email.
# When an employee sends an email to another employee, a communication channel has 
# been created, allowing the sender to provide information to the receiver, but not 
# vice versa.
# Based on the emails sent in the data, is it possible for information to go from every
# employee to every other employee?
# Part 2. Now assume that a communication channel established by an email allows 
# information to be exchanged both ways.
# Based on the emails sent in the data, is it possible for information to go from every
# employee to every other employee?
# This function should return a tuple of bools (part1, part2).

question3 <- function() {
  # YOUR CODE HERE

}


# QUESTION 4
# How many nodes are in the largest (in terms of nodes) weakly connected component?
# This function should return an int.

question4 <- function() {
  # YOUR CODE HERE

}

# QUESTION 5
# How many nodes are in the largest (in terms of nodes) strongly connected component?
# This function should return an int

question5 <- function() {
  # YOUR CODE HERE

}

# QUESTION 6
# Using igraph find the subgraph of nodes in a largest strongly connected component. 
# This function should return an igraph.

question6 <- function() {
  # YOUR CODE HERE

}

# QUESTION 7
# What is the average distance between nodes in question 6's graph?
# This function should return a float.
question7 <- function() {
  # YOUR CODE HERE

}

# QUESTION 8
# What is the largest possible distance between two employees in question 6's graph?
# This function should return an int.
question8 <- function() {
  # YOUR CODE HERE

}

# QUESTION 9
# What is the set of nodes in question 6's graph with eccentricity equal to the diameter?
# In other words, who is at the outer edges of the communication reciepient spectrum.
# Hint: this is a directed graph, so how eccentricity is measured it would yield different results.
# This function should return a set(vector) of the node(s).
question9 <- function() {
  # YOUR CODE HERE

}

# QUESTION 10
# What is the set of node(s) in question 6's graph with eccentricity equal to the radius?
# This function should return a set of the node(s).
question10 <- function() {
  # YOUR CODE HERE

}

# QUESTION 11
# Which node in question 6's graph has the most shortest paths to other nodes whose distance
# equal the diameter of g?
# In other words, of those that are at the edges (question 9), who is the "farthest" out.
# How many of these paths are there for that person?
# This function should return a tuple (name of node, number of paths).

question11 <- function() {
  # YOUR CODE HERE

}

# QUESTION 12 
# Suppose you want to prevent communication from flowing to the node
# that you found in the previous question from any node in the center of the graph,
# what is the smallest number of nodes you would need to remove from the graph
# (you're not allowed to remove the node from the previous question or the
# center nodes)?
# Hint: The center is the set of nodes with eccentricity equal to radius.
# This function should return an integer.

question12 <- function() {
  # YOUR CODE HERE

}

# QUESTION 13
# Construct an undirected graph using question 6's graph (you can ignore the attributes).
# This function should return a graph.

question13 <- function() {
  # YOUR CODE HERE

}

# QUESTION 14
# What is the transitivity and average clustering coefficient of the undirected graph?
# This function should return a tuple (transitivity, avg clustering).
# Further research: Is this a highly connected graph with multiple dependencies based
# on your results?

question14 <- function() {
  # YOUR CODE HERE

}

