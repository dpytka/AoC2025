# frozen_string_literal: true

# To complex recur call for bigger matrix
matrix = File.readlines('input_test.txt', chomp: true).map do |line|
  line.split('')
end

matrix.each { |l| puts l.join }
def matrix_traversal(matrix, row, col)
  return 1 if row == matrix.size - 1

  if matrix[row][col] == '^'
    matrix_traversal(matrix, row + 1, col - 1) + matrix_traversal(matrix, row + 1, col + 1)
  else
    matrix_traversal(matrix, row + 1, col)
  end
end

col = matrix[0].index('S')
p matrix_traversal(matrix, 0, col)
