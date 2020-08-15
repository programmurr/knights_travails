# frozen_string_literal: true

class Cell
  attr_accessor :value, :co_ords

  def initialize(value = '')
    @value = value
    @co_ords = []
  end
end
