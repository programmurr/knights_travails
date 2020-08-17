# frozen_string_literal: true

class TempKnight
  MOVES = [2, 2, -2, -2, 1, 1, -1, -1].zip([1, -1, 1, -1, 2, -2, 2, -2])

  attr_accessor :piece, :position, :nodes
  def initialize
    @piece = 'Tp'
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

  private

  def all_moves(array)
    MOVES.map { |a, b| [array.first + a, array.last + b] }
  end
end
