# frozen_string_literal: true

matrix = File.readlines('input.txt', chomp: true).map { |line| line.split('') }

result = matrix.transpose.each_with_object([0]) do |column, acc|
  operator = column.last
  acc[1] = operator if %w[+ *].include?(operator)
  col = column[..-1].join
  if col.strip == ''
    acc[0] += acc[2]
    acc.pop(acc.size - 2)
  elsif acc.size == 2
    acc[2] = col.to_i
  elsif acc[1] == '+'
    acc[2] += col.to_i
  else
    acc[2] *= col.to_i
  end
end

p result[0] + result[2]
