# frozen_string_literal: true

class Rolls
  MARKER = '@'
  REMOVED = 'x'
  MAX_ADJACENT_COUNT = 5

  attr_reader :grid

  def initialize(filename)
    @grid = File.readlines(filename, chomp: true).map(&:chars)
  end

  def calculate_removed_rolls
    removed_count = 0
    grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        removed_count += 1 if cell == MARKER && should_remove?(row_index, col_index)
      end
    end
    removed_count
  end

  private

  def should_remove?(row_index, col_index)
    adjacent_count = count_adjacent_markers(row_index, col_index)
    if adjacent_count < MAX_ADJACENT_COUNT
      grid[row_index][col_index] = REMOVED
      true
    else
      false
    end
  end

  def count_adjacent_markers(row_index, col_index)
    row_range = valid_range(row_index, grid.size)
    col_range = valid_range(col_index, grid.first.size)

    row_range.sum do |row|
      col_range.count do |col|
        [MARKER, REMOVED].include?(grid[row][col])
      end
    end
  end

  def valid_range(index, max_size)
    start_index = [index - 1, 0].max
    end_index = [index + 1, max_size - 1].min
    (start_index..end_index)
  end
end

# Run the calculation and print the result
puts Rolls.new('input.txt').calculate_removed_rolls
