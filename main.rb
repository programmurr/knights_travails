# frozen_string_literal: true

require 'pry'
require_relative 'board'
require_relative 'knight'

board = Board.new
knight = Knight.new
# knight_graph = Graph.new
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
  board.set_cell(x1, y1, knight)
  board.formatted_grid
  possible_moves = knight.possible_moves(knight.position)
  knight.add_nodes(knight.position, possible_moves)
  knight.add_edges_between_nodes
  potential_target = knight.retrieve_target(knight.nodes[:current_position].successors, target)
  if potential_target == target
    x3 = potential_target[0]
    y3 = potential_target[1]
    board.set_cell(x3, y3, knight)
    knight.move_knight(potential_target)
    board.clear_cell(x1, y1)
    knight.nodes = knight.clear_nodes
    puts "Number of moves: #{counter}"
    board.formatted_grid
    break
  else
    next_move = potential_target.co_ord
    knight.move_knight(next_move)
    board.clear_cell(x1, y1)
    knight.nodes = knight.clear_nodes
    x1 = next_move[0]
    y1 = next_move[1]
    puts "Number of moves: #{counter}"
    counter += 1
  end
end
