# frozen_string_literal: true

matrix = File.readlines('input.txt').map { |line| line.split(' ') }

result = matrix.transpose.sum do |column|
  operator = column.last
  numbers = column[0...-1].map(&:to_i)

  operator == '+' ? numbers.sum : numbers.reduce(:*)
end

p result
