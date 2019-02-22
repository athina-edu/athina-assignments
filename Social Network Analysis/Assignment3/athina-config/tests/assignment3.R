# DEFAULT CODE TO GET YOU STARTED
library(igraph)

# In this assignment you will explore measures of centrality on two networks,
# a friendship network in Part 1, and a blog network in Part 2.

# PART 1

# Answer questions 1-4 using the network G1, a network of friendships at a 
# university department. Each node corresponds to a person, and an edge indicates
# friendship.
# The network has been loaded as an igraph object G1.

g1 <- read_graph("friendship.gml", format = c("gml"))

# QUESTION 1
# Find the degree centrality, closeness centrality, and normalized betweeness
# centrality (excluding endpoints) of node 100.
# This function should return a tuple of floats (degree_centrality, closeness_centrality,
# betweenness_centrality).

question1 <- function() {
  # YOUR CODE HERE

}


# For Questions 2, 3, and 4, use one of the covered centrality measures to rank the 
# nodes and find the most appropriate candidate.

# QUESTION 2 
# Suppose you are employed by an online shopping website and are
# tasked with selecting one user in network G1 to send an online shopping
# voucher to. We expect that the user who receives the voucher will send it to
# their friends in the network. You want the voucher to reach as many nodes as
# possible. The voucher can be forwarded to multiple users at the same time, but
# the travel distance of the voucher is limited to one step, which means if the
# voucher travels more than one step in this network, it is no longer valid.
# Apply your knowledge in network centrality to select the best candidate for
# the voucher.
# This function should return an integer, the name of the node.

question2 <- function() {
  # YOUR CODE HERE

}

# QUESTION 3 
# Now the limit of the voucher's travel distance has been removed.
# Because the network is connected, regardless of who you pick, every node in
# the network will eventually receive the voucher. However, we now want to
# ensure that the voucher reaches the nodes in the lowest average number of
# hops. How would you change your selection strategy? Write a function to tell
# us who is the best candidate in the network under this condition. 
# This function should return an integer, the name of the node.

question3 <- function() {
  # YOUR CODE HERE

}

# QUESTION 4 
# Assume the restriction on the voucher's travel distance is still
# removed, but now a competitor has developed a strategy to remove a person from
# the network in order to disrupt the distribution of your company's voucher.
# Identify the single riskiest person to be removed under your competitor's
# strategy? 
# This function should return an integer, the name of the node.

question4 <- function() {
  # YOUR CODE HERE

}

# PART 2 
# G2 is a directed network of political blogs, where nodes correspond to
# a blog and edges correspond to links between blogs. Use your knowledge of
# PageRank and HITS to answer Questions 5-9.

g2 <- read_graph("blogs.gml", format = c("gml"))


# QUESTION 5
# Apply the Scaled Page Rank Algorithm to this network. 
# Find the Page Rank of node 'realclearpolitics.com' with damping value 0.85.
# This function should return a float.

question5 <- function() {
  # YOUR CODE HERE

}

# QUESTION 6
# Apply the Scaled Page Rank Algorithm to this network with damping value 0.85.
# Find the 5 nodes with highest Page Rank (the most influential blogs).
# This function should return a list of the top 5 blogs in desending order of Page Rank.

question6 <- function() {
  # YOUR CODE HERE

}

# QUESTION 7
# Apply the HITS Algorithm to the network to find the hub and authority scores 
# of node 'realclearpolitics.com'.
# Your result should return a tuple of floats (hub_score, authority_score).

question7 <- function() {
  # YOUR CODE HERE

}

# QUESTION 8
# Apply the HITS Algorithm to this network to find the 5 nodes with highest hub scores.
# This function should return a list of the top 5 blogs in desending order of hub scores.

question8 <- function() {
  # YOUR CODE HERE

}

# QUESTION 9
# Apply the HITS Algorithm to this network to find the 5 nodes with highest authority scores.
# This function should return a list of the top 5 blogs in desending order of authority scores.
question9 <- function() {
  # YOUR CODE HERE

}

