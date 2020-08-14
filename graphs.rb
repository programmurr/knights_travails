# frozen_string_literal: true

require 'pry'

class Node
  attr_accessor :successors, :co_ord, :name
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
