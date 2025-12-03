# frozen_string_literal: true

def battery_bank_jolts(battery_bank)
  first = battery_bank[..-2].max
  first_idx = battery_bank.index(first)
  second = battery_bank[first_idx + 1..].max

  "#{first}#{second}".to_i
end

p File.readlines('input.txt', chomp: true)
      .map { |el| el.split('') }
      .map { |line| battery_bank_jolts(line) }
      .sum
