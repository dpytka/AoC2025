# frozen_string_literal: true

lines = File.readlines('input.txt', chomp: true)

i_ranges = lines.select { |line| line.include?('-') }
                .map { |line| Range.new(*line.split('-').map(&:to_i)) }

i_ids = lines.reject { |line| line.include?('-') || line.empty? }
             .map(&:to_i)


result = i_ids.count do |id|
  i_ranges.any? { |range| range.include?(id) }
end

p result
