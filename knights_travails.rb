# frozen_string_literal: true

require 'pry'

class Cell
  attr_accessor :value, :co_ords

  def initialize(value = '')
    @value = value
    @co_ords = []
  end
end

class Knight
  attr_accessor :piece, :position
  def initialize
    @piece = 'Kn'
    @position = nil
  end

  def get_knight_position(grid)
    grid.each do |row|
      row.each do |cell|
        return @position = cell.co_ords if cell.value
      end
    end
  end
end

class Board
  attr_reader :grid

  def initialize(input = {})
    @grid = input.fetch(:grid, default_grid)
  end

  def get_cell(x, y)
    grid[x][y]
  end

  def set_cell(x, y, value)
    get_cell(x, y).value = value
    grid[x][y].co_ords = [x, y]
  end

  def formatted_grid
    grid.each do |row|
      puts row.map { |cell| cell.value ? '_' : cell.value }.join(' ')
    end
  end

  private

  def default_grid
    Array.new(8) { Array.new(8) { Cell.new } }
  end
end

board = Board.new
knight = Knight.new
board.set_cell(7, 1, knight)
board.formatted_grid
knight.get_knight_position(board.grid)
p board.get_cell(7, 1)
p knight
