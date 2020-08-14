# frozen_string_literal: true

require 'pry'
require_relative 'chess'
require_relative 'graphs'

def retrieve_target(nodes, target)
  nodes.each do |node|
    return node.co_ord if node.co_ord == target
  end
  nodes.sample
end

board = Board.new
white_knight = Knight.new
graph = Graph.new
puts 'Enter the x coordinate of the cell you want to place your knight'
x1 = gets.chomp.to_i
puts 'Enter the y coordinate of the cell you want to place your knight'
y1 = gets.chomp.to_i
puts 'Enter the x coordinate of the cell you want to get to'
x2 = gets.chomp.to_i
puts 'Enter the y coordinate of the cell you want to get to'
y2 = gets.chomp.to_i
target = [x2, y2]
counter = 1
loop do
  board.set_cell(x1, y1, white_knight)
  board.formatted_grid
  possible_moves = white_knight.possible_moves(white_knight.position)
  graph.add_nodes_to_graph(white_knight.position, possible_moves)
  graph.add_edges_between_nodes
  potential_target = retrieve_target(graph.nodes[:current_position].successors, target)
  if potential_target == target
    x3 = potential_target[0]
    y3 = potential_target[1]
    board.set_cell(x3, y3, white_knight)
    graph.move_node(potential_target)
    board.clear_cell(x1, y1)
    graph.nodes = graph.clear_nodes
    puts "Number of moves: #{counter}"
    board.formatted_grid
    break
  else
    next_move = potential_target.co_ord
    graph.move_node(next_move)
    board.clear_cell(x1, y1)
    graph.nodes = graph.clear_nodes
    x1 = next_move[0]
    y1 = next_move[1]
    puts "Number of moves: #{counter}"
    counter += 1
  end
end
