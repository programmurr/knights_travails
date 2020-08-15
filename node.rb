# frozen_string_literal: true

class Node
  attr_accessor :successors, :co_ord, :name
  def initialize(name, co_ord)
    @name = name
    @co_ord = co_ord
    @successors = []
  end

  def add_edge(successor)
    @successors << successor
  end

  def to_s
    "#{@name} is #{@co_ord}, possible positions are -> #{@successors.map(&:co_ord)}"
  end
end
