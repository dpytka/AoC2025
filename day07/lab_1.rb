# frozen_string_literal: true

matrix = File.readlines('input.txt', chomp: true).map do |line|
  line.split('')
end

splits = 0
matrix.each_with_index do |l, idx|
  break if idx == matrix.size - 1

  next_row = matrix[idx + 1]
  t_beams = l.each_index.select { |i| %w[S |].include?(l[i]) }
  t_beams.each do |i|
    case next_row[i]
    when '.'
      next_row[i] = '|'
    when '^'
      next_row[i - 1] = '|'
      next_row[i + 1] = '|'
      splits += 1
    end
  end
end

p splits
