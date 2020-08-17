# frozen_string_literal: true

# Represent each cell in the board class, the cells of a chess game board
# Knights and Temp_Knights can be placed upon them
class Cell
  attr_accessor :value, :co_ords, :counter, :remove

  def initialize(value = '')
    @value = value
    @co_ords = []
    @counter = nil
    @remove = false
  end
end
