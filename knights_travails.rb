# frozen_string_literal: true

class Cell
  attr_accessor :value

  def initialize(value = '')
    @value = value
  end
end

class Knight
  attr_accessor :piece
  def initialize
    @piece = 'Kn'
  end
end

class Board
  attr_reader :grid

  def initialize(input = {})
    @grid = input.fetch(:grid, default_grid)
  end

  def get_cell(x, y)
    grid[y][x]
  end

  def set_cell(x, y, value)
    get_cell(x, y).value = value
  end

  def formatted_grid
    grid.each do |row|
      puts row.map { |cell| cell.value.empty? ? '_' : cell.value }.join(' ')
    end
  end

  private

  def default_grid
    Array.new(8) { Array.new(8) { Cell.new } }
  end
end

board = Board.new
knight = Knight.new.piece
board.set_cell(0, 0, knight)
board.set_cell(7, 7, knight)
board.formatted_grid
p board.get_cell(7, 7)
p board.get_cell(7, 7).value
