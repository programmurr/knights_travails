# frozen_string_literal: true

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
    @position = []
  end
end

class Board
  attr_reader :grid

  def initialize(input = {})
    @grid = input.fetch(:grid, default_grid)
    set_cell_coordinates
  end

  def get_cell(x, y)
    grid[x][y]
  end

  def set_cell(x, y, piece)
    get_cell(x, y).value = piece
    piece.position = [x, y]
  end

  def formatted_grid
    grid.each do |row|
      puts row.map { |cell| cell.value == '' ? '_' : cell.value.piece.to_s }.join(' ')
    end
  end

  private

  def default_grid
    Array.new(8) { Array.new(8) { Cell.new } }
  end

  def set_cell_coordinates
    x = 0
    while x < 8
      y = 0
      while y < 8
        grid[x][y].co_ords = [x, y]
        y += 1
      end
      x += 1
    end
  end
end

board = Board.new
white_knight = Knight.new
black_knight = Knight.new
board.set_cell(7, 1, white_knight)
board.set_cell(0, 6, black_knight)
board.formatted_grid
p board.get_cell(7, 1)
p board.get_cell(0, 6)
p white_knight
p black_knight

