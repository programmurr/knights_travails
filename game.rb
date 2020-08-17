# frozen_string_literal: true

require_relative 'board'
require_relative 'knight'
require_relative 'temp_knight'

# Controls all of the methods to actually run the game sequence
class Game
  attr_accessor :x1, :y1, :x2, :y2, :board, :start_knight, :end_knight, :temp_knight, :temp_queue, :final_queue, :count

  def initialize
    @x1 = x1_coordinate
    @y1 = y1_coordinate
    @x2 = x2_coordinate
    @y2 = y2_coordinate
    @board = Board.new
    @start_knight = Knight.new
    @end_knight = Knight.new
    @temp_knight = TempKnight.new
    @temp_queue = []
    @final_queue = []
    @count = 1
  end

  def knight_moves(start, target)
    display_positions(start, target)
    set_board_cells(start, target)
    temp_knight.position = [start[0], start[1]]
    assign_to_queues(target)
    set_queue_counters
    start_possible_moves = start_knight.possible_moves(start)
    end_possible_moves = temp_knight.possible_moves(target)
    map_finish_to_start(end_possible_moves, start_possible_moves)
    end_calculations(start_possible_moves)
  end

  private

  def x1_coordinate
    puts 'Enter the x co-ordinate of where you want to start (from 0 to 7):'
    while num = gets.chomp.to_i
      return num if !num.negative? && num < 8

      puts 'Please enter a number from 0 to 7'
    end
  end

  def y1_coordinate
    puts 'Enter the y co-ordinate of where you want to start (from 0 to 7):'
    while num = gets.chomp.to_i
      return num if !num.negative? && num < 8

      puts 'Please enter a number from 0 to 7'
    end
  end

  def x2_coordinate
    puts 'Enter the x co-ordinate of where you want to finish (from 0 to 7):'
    while num = gets.chomp.to_i
      return num if !num.negative? && num < 8

      puts 'Please enter a number from 0 to 7'
    end
  end

  def y2_coordinate
    puts 'Enter the y co-ordinate of where you want to finish (from 0 to 7):'
    while num = gets.chomp.to_i
      return num if !num.negative? && num < 8

      puts 'Please enter a number from 0 to 7'
    end
  end

  def display_positions(start, target)
    puts "Your start position is #{start}"
    puts "Your end position is #{target}"
    sleep 3
    p start
  end

  def assign_to_queues(target)
    board.grid.each do |row|
      row.each do |cell|
        temp_queue << cell if cell.co_ords == target
        final_queue << cell if cell.co_ords == target
      end
    end
  end

  def set_queue_counters
    temp_queue[0].counter = 0
    final_queue[0].counter = 0
  end

  def push_to_temp_queue(possible_moves)
    possible_moves.each do |position|
      board.grid.each do |row|
        row.each do |cell|
          temp_queue << cell if cell.co_ords == position
          cell.counter = count if cell.co_ords == position && cell.counter.nil?
        end
      end
    end
  end

  def queue_check
    final_queue.each do |final_cell|
      temp_queue.each do |temp_cell|
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

  def append_to_final_queue
    temp_queue.each do |element|
      final_queue << element
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

  def end_calculations(start_moves)
    cells_containing_path = board.remove_empty_cells
    start_knight.start_positions(cells_containing_path, start_moves)
    start_knight.move_to_finish(cells_containing_path)
    puts "Done! You made it in #{start_knight.number_of_moves} moves!"
  end

  def set_board_cells(start, target)
    board.set_cell(start[0], start[1], start_knight)
    board.set_cell(target[0], target[1], end_knight)
  end

  def map_finish_to_start(end_possible_moves, start_possible_moves)
    loop do
      push_to_temp_queue(end_possible_moves)
      queue_check
      self.final_queue = remove_elements(final_queue)
      self.temp_queue = remove_elements(temp_queue)
      temp_queue.shift
      append_to_final_queue
      board.put_temp_knights_on_board
      break if path_discovered?(start_possible_moves, end_possible_moves)

      end_possible_moves = board.renew_possible_moves(count)
      self.count += 1
    end
  end
end
