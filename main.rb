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

graph.add_nodes_to_graph(white_knight.position, possible_moves)
graph.add_edges_between_nodes
loop do
  input = graph.user_selects_node
  graph.move_node(input)
  graph.nodes = graph.clear_nodes
  x2 = graph.split_coords_x(graph[:current_position])
  y2 = graph.split_coords_y(graph[:current_position])
  board.set_cell(x2, y2, white_knight)
  board.clear_cell(x1, y1)
  possible_moves2 = white_knight.possible_moves(white_knight.position)
  board.formatted_grid
  graph.add_nodes_to_graph(white_knight.position, possible_moves2)
  graph.add_edges_between_nodes
  board.clear_cell(x2, y2)
end
