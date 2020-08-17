# frozen_string_literal: true

require_relative 'cell'

# Generates an unseen board for the knight and temp_knight pieces to manoeuvre on
class Board
  attr_accessor :grid

  def initialize(input = {})
    @grid = input.fetch(:grid, default_grid)
    set_cell_coordinates
  end

  def set_cell(x, y, piece)
    get_cell(x, y).value = piece
    piece.position = [x, y]
  end

  def clear_cell(x, y)
    grid[x][y].value = ''
  end

  def put_temp_knights_on_board
    grid.each do |row|
      row.each do |cell|
        if cell.counter&.positive?
          set_cell(cell.co_ords[0], cell.co_ords[1], TempKnight.new) unless cell.value.piece == 'Kn'
        end
        rescue NoMethodError
          set_cell(cell.co_ords[0], cell.co_ords[1], TempKnight.new)
      end
    end
  end

  def remove_empty_cells
    return_array = []
    grid.each do |row|
      row.each do |cell|
        return_array << cell if cell.value != ''
      end
    end
    return_array
  end

  def renew_possible_moves(count)
    return_array = []
    grid.each do |row|
      row.each do |cell|
        return_array << cell.value.possible_moves(cell.co_ords) if cell.value.class == TempKnight && cell.counter == count
      end
    end
    left = []
    right = []
    return_array.flatten.each_with_index { |element, idx| idx.even? ? left << element : right << element }
    return_array = left.zip(right)
  end

  private

  def get_cell(x, y)
    grid[x][y]
  end

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
