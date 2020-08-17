# frozen_string_literal: true

require_relative 'node'

class TempKnight
  MOVES = [2, 2, -2, -2, 1, 1, -1, -1].zip([1, -1, 1, -1, 2, -2, 2, -2])

  attr_accessor :piece, :position, :nodes
  def initialize
    @piece = 'Tp'
    @position = []
    @nodes = {}
  end

  def possible_moves(array)
    all_moves = all_moves(array)
    possible_array = []
    all_moves.each do |co_ord|
      next unless co_ord[0] < 8 && co_ord[1] < 8

      possible_array << co_ord if !co_ord[0].negative? && !co_ord[1].negative?
    end
    possible_array
  end

  def add_nodes(current_position, possible_moves)
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

  def retrieve_target(nodes, target)
    nodes.each do |node|
      return node.co_ord if node.co_ord == target
    end
    nodes.sample
  end

  def move_knight(array)
    nodes[:current_position].successors.each do |node|
      if node.co_ord == array
        nodes[:current_position] = node
        nodes[:current_position].name = :current_position
      end
    end
  end

  def clear_nodes
    nodes.slice(:current_position)
  end

  private

  def all_moves(array)
    MOVES.map { |a, b| [array.first + a, array.last + b] }
  end

  def add_node(node)
    @nodes[node.name] = node
  end

  def add_edge(predecessor_name, successor_name)
    @nodes[predecessor_name].add_edge(@nodes[successor_name])
  end
end
