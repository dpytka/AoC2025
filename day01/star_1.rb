# frozen_string_literal: true

dial = 50
password = 0
File.readlines('input_1.txt').map(&:strip).each do |l|
  move = l[1..].to_i
  case l[0]
  when 'L'
    dial -= move
  else
    dial += move
  end
  dial %= 100
  password += 1 if dial.zero?
end

p "Password is: #{password}"
