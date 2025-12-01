# frozen_string_literal: true

dial = 50
password = 0
File.readlines('input_1.txt').map(&:strip).each do |l|
  move = l[1..].to_i
  case l[0]
  when 'L'
    password += (99 - (dial + 99) % 100 + move) / 100
    dial = (100 + dial - move % 100) % 100
  when 'R'
    password += ((dial + move) / 100)
    dial = (dial + move) % 100
  else
    pass
  end
end

p "Password is: #{password}"
