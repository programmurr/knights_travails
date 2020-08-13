# frozen_string_literal: true

require 'pry'
require_relative 'chess'
require_relative 'graphs'

board = Board.new
white_knight = Knight.new
board.set_cell(7, 1, white_knight)
board.formatted_grid
possible_moves = white_knight.possible_moves(white_knight.position)
knight_tree = MoveGraph.new(possible_moves)
p knight_tree
