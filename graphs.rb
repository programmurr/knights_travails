# frozen_string_literal: true

require 'pry'
require_relative 'chess'

class Node
  attr_reader :name
  def initialize(name, co_ord)
    @name = name
    @co_ord = co_ord
    @successors = []
  end

  def add_edge(successor)
    @successors << successor
  end

  def to_s
    "#{@name} -> [#{@successors.map(&:name).join(' ')}]"
  end
end

class Graph
  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.name] = node
  end

  def add_edge(predecessor_name, successor_name)
    @nodes[predecessor_name].add_edge(@nodes[successor_name])
  end

  def [](name)
    @nodes[name]
  end
end

graph = Graph.new
graph.add_node(Node.new(:current_pos, [7, 1]))
graph.add_node(Node.new(:move1, [5, 0]))
graph.add_node(Node.new(:move2, [5, 2]))
graph.add_node(Node.new(:move3, [6, 3]))
graph.add_edge(:current_pos, :move1)
graph.add_edge(:current_pos, :move2)
graph.add_edge(:current_pos, :move3)
p graph[:current_pos]

# Make a program that:
# Gets knight's current position
# Turns it into a node
# Calculates the next possible positions
# Turns them into nodes
# Adds all those nodes to the graph
# Traverses from one node to another when told
# Re-calculates next possible positions
# Can traverse to one of them
# And so on...
