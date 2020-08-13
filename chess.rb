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
  MOVES = [2, 2, -2, -2, 1, 1, -1, -1].zip([1, -1, 1, -1, 2, -2, 2, -2])

  attr_accessor :piece, :position
  def initialize
    @piece = 'Kn'
    @position = []
  end

  def possible_moves(array)
    all_moves = all_moves(array)
    possible_array = []
    all_moves.each do |co_ord|
      next unless co_ord[0] < 8 && co_ord[1] < 8

      possible_array << co_ord if !co_ord[0].negative? && !co_ord[1].negative?
    end
    possible_array
  end

  def move
    # Execute a move from one cell to another
  end

  private

  def all_moves(array)
    MOVES.map { |a, b| [array.first + a, array.last + b] }
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

