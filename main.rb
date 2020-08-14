# frozen_string_literal: true

require 'pry'
require_relative 'chess'
require_relative 'graphs'

board = Board.new
white_knight = Knight.new
puts 'Enter the x coordinate of the cell you want'
x1 = gets.chomp.to_i
puts 'Enter the y coordinate of the cell you want'
y1 = gets.chomp.to_i
board.set_cell(x1, y1, white_knight)
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

# Needs a check to ensure user picks valid number
def user_selects_node(graph)
  puts graph[:current_position]
  puts 'Choose your next position by entering the number of the move you want to make:'
  puts graph[:current_position].successors
  input = gets.chomp.to_i
  input -= 1
end

def move_node(graph, input)
  graph.nodes[:current_position] = graph.nodes[:current_position].successors[input]
  graph[:current_position].name = :current_position
end

def split_coords_x(node)
  node.co_ord[0]
end

def split_coords_y(node)
  node.co_ord[1]
end

def clear_nodes(graph)
  graph.nodes = graph.nodes.slice(:current_position)
end

add_nodes_to_graph(graph, white_knight.position, possible_moves)
add_edges_between_nodes(graph)
loop do
  input = user_selects_node(graph)
  move_node(graph, input)
  clear_nodes(graph)
  x2 = split_coords_x(graph[:current_position])
  y2 = split_coords_y(graph[:current_position])
  board.set_cell(x2, y2, white_knight)
  board.clear_cell(x1, y1)
  binding.pry
  possible_moves2 = white_knight.possible_moves(white_knight.position)
  board.formatted_grid
  add_nodes_to_graph(graph, white_knight.position, possible_moves2)
  add_edges_between_nodes(graph)
  board.clear_cell(x2, y2)
  p white_knight
  p graph
end
