# frozen_string_literal: true

class Knight
  MOVES = [2, 2, -2, -2, 1, 1, -1, -1].zip([1, -1, 1, -1, 2, -2, 2, -2])

  attr_accessor :piece, :position, :nodes, :counter, :number_of_moves
  def initialize
    @piece = 'Kn'
    @position = []
    @nodes = []
    @counter = nil
    @number_of_moves = 0
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
    self.position = nodes.sample
    self.counter = position.counter
    self.nodes = []
  end

  def calculate_next_move(path_cells)
    current_possible_moves = possible_moves(position.co_ords)
    path_cells.each do |cell|
      current_possible_moves.each do |move|
        nodes << cell if cell.co_ords == move && cell.counter == counter - 1
      end
    end
  end

  def start_positions(path_cells, start_moves)
    path_cells.each do |cell|
      start_moves. each do |move|
        nodes << cell if cell.co_ords == move
      end
    end
  end

  private

  def all_moves(array)
    MOVES.map { |a, b| [array.first + a, array.last + b] }
  end
end
