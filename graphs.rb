# frozen_string_literal: true

require 'pry'

class Node
  attr_reader :name
  attr_accessor :successors, :co_ord
  def initialize(name, co_ord)
    @name = name
    @co_ord = co_ord
    @successors = []
  end

  def add_edge(successor)
    @successors << successor
  end

  def to_s
    "#{@name} is #{@co_ord}, possible positions are -> #{@successors.map(&:co_ord)}"
  end
end

class Graph
  attr_accessor :nodes
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

# Make graph
# def add_nodes(graph, current_position, possible_moves)
# - Add current position as node to graph
# - Add all possible moves as nodes to graph
# - Return updated graph
# end
# def add_edges(graph)
# - Add edges from current position to all possible moves
# - Return updated graph
# end
# def move_node(graph)
# - User selects which node to move to
# - Node moves to that node
# - Return current (new) node
# end
# Re-calculate possible moves from current node
# Loop to beginning?
