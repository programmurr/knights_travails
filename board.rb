# frozen_string_literal: true

require_relative 'cell'

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

  def formatted_grid
    grid.each do |row|
      puts row.map { |cell| cell.value == '' ? '_' : cell.value.piece.to_s }.join(' ')
    end
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
