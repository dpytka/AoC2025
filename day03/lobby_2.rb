# frozen_string_literal: true

def battery_bank_jolts(battery_bank)
  end_size = 12
  batteries_to_remove = battery_bank.size - end_size

  batteries_to_remove.times do
    (1...battery_bank.size).each do |i|
      battery_bank.delete_at(i - 1) && break if battery_bank[i - 1] < battery_bank[i]
    end
  end

  battery_bank[0...end_size].join.to_i
end

p File.readlines('input.txt', chomp: true)
      .map { |el| el.split('') }
      .map { |line| battery_bank_jolts(line) }
      .sum
