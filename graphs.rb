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

  def add_nodes_to_graph(current_position, possible_moves)
    add_node(Node.new(:current_position, current_position))

    possible_moves.each.with_index do |move, index|
      add_node(Node.new("Move#{index + 1}", move))
    end
  end

  def add_edges_between_nodes
    iteration_length = nodes.length
    x = 1
    while x < iteration_length
      add_edge(:current_position, "Move#{x}")
      x += 1
    end
  end

  def move_node(input)
    nodes[:current_position] = nodes[:current_position].successors[input]
    nodes[:current_position].name = :current_position
  end

  def clear_nodes
    nodes.slice(:current_position)
  end

  def split_coords_x(node)
    node.co_ord[0]
  end

  def split_coords_y(node)
    node.co_ord[1]
  end

  # Needs a check to ensure user picks valid number
  def user_selects_node
    puts 'Choose your next position by entering the number of the move you want to make:'
    puts nodes[:current_position].successors
    input = gets.chomp.to_i
    input -= 1
  end
end
