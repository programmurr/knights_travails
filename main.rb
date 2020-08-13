# frozen_string_literal: true

require 'pry'
require_relative 'chess'
require_relative 'graphs'

board = Board.new
white_knight = Knight.new
board.set_cell(7, 1, white_knight)
board.formatted_grid
possible_moves = white_knight.possible_moves(white_knight.position)

graph = Graph.new

def add_nodes_to_graph(graph, current_position, possible_moves)
  graph.add_node(Node.new(:current_position, current_position))

  possible_moves.each.with_index do |move, index|
    graph.add_node(Node.new("Move#{index + 1}", move))
  end
  graph
end

def add_edges_between_nodes(graph)
  iteration_length = graph.nodes.length
  x = 1
  while x < iteration_length
    graph.add_edge(:current_position, "Move#{x}")
    x += 1
  end
  graph
end

def user_selects_node(graph)
  puts graph[:current_position]
  puts 'Choose your next position by entering the number of the move you want to make:'
  puts graph[:current_position].successors
  input = gets.chomp.to_s
  input
end

def move_node(graph)
  # Get return value of user_selects_node
  # Node moves to that node
  # Return current (new) node
end

add_nodes_to_graph(graph, white_knight.position, possible_moves)
add_edges_between_nodes(graph)
user_selects_node(graph)
# move_node(graph)
