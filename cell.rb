# frozen_string_literal: true

class Cell
  attr_accessor :value, :co_ords, :counter, :remove

  def initialize(value = '')
    @value = value
    @co_ords = []
    @counter = nil
    @remove = false
  end
end
