# frozen_string_literal: true

require 'pry'
require_relative 'chess'
require_relative 'graphs'

board = Board.new
white_knight = Knight.new
board.set_cell(7, 1, white_knight)
board.formatted_grid
p possible_moves = white_knight.possible_moves(white_knight.position)
