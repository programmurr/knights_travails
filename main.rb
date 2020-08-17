# frozen_string_literal: true

require 'pry'
require_relative 'board'
require_relative 'knight'
require_relative 'temp_knight'

def queue_check(final, temp)
  final.each do |final_cell|
    temp.each do |temp_cell|
      if final_cell.co_ords == temp_cell.co_ords && final_cell.counter < temp_cell.counter
        temp_cell.remove = true
      elsif final_cell.co_ords == temp_cell.co_ords && final_cell.counter > temp_cell.counter
        final_cell.remove = true
      end
    end
  end
end

def remove_elements(array)
  return_array = []
  array.each do |cell|
    return_array << cell if cell.remove == false
  end
  return_array
end

def renew_possible_moves(board, count)
  return_array = []
  board.grid.each do |row|
    row.each do |cell|
      return_array << cell.value.possible_moves(cell.co_ords) if cell.value.class == TempKnight && cell.counter == count
    end
  end
  left = []
  right = []
  return_array.flatten.each_with_index { |element, idx| idx.even? ? left << element : right << element }
  return_array = left.zip(right)
end

def append_to_final_queue(final_queue, temp_queue)
  temp_queue.each do |element|
    final_queue << element
  end
end

def push_to_temp_queue(board, possible_moves, temp_queue, count)
  possible_moves.each do |position|
    board.grid.each do |row|
      row.each do |cell|
        temp_queue << cell if cell.co_ords == position
        cell.counter = count if cell.co_ords == position && cell.counter.nil?
      end
    end
  end
end

def path_discovered?(start_moves, end_moves)
  start_moves.each do |start_cell|
    end_moves.each do |end_cell|
      return true if start_cell == end_cell
    end
  end
  false
end

def assign_to_queues(board, final_queue, temp_queue, target)
  board.grid.each do |row|
    row.each do |cell|
      temp_queue << cell if cell.co_ords == target
      final_queue << cell if cell.co_ords == target
    end
  end
end

board = Board.new
start_knight = Knight.new
end_knight = Knight.new
temp_knight = TempKnight.new
x1 = 4
y1 = 7
x2 = 7
y2 = 7
start = [x1, y1]
target = [x2, y2]
board.set_cell(x1, y1, start_knight)
board.set_cell(x2, y2, end_knight)
temp_knight.position = [x1, y1]
temp_queue = []
final_queue = []
assign_to_queues(board, final_queue, temp_queue, target)
temp_queue[0].counter = 0
final_queue[0].counter = 0
count = 1
start_possible_moves = start_knight.possible_moves(start)
end_possible_moves = temp_knight.possible_moves(target)
loop do
  push_to_temp_queue(board, end_possible_moves, temp_queue, count)
  queue_check(final_queue, temp_queue)
  final_queue = remove_elements(final_queue)
  temp_queue = remove_elements(temp_queue)
  temp_queue.shift
  append_to_final_queue(final_queue, temp_queue)
  board.put_temp_knights_on_board
  board.formatted_grid
  break if path_discovered?(start_possible_moves, end_possible_moves)

  end_possible_moves = renew_possible_moves(board, count)
  count += 1
  puts '---'
end
binding.pry
# Push the shortest route to the start_knight nodes (be aware, start_knight counter could initially be nil, equal to or less than the nodes around it)
# Only push nodes the start_knight can actually move to, e.g. it cannot move to 0,2 if the start is 0,0
# Move the knight along the nodes
