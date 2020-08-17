# frozen_string_literal: true

require 'pry'
require_relative 'game'

game = Game.new
start = [game.x1, game.y1]
target = [game.x2, game.y2]

game.knight_moves(start, target)
