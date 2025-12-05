# frozen_string_literal: true

lines = File.readlines('input.txt', chomp: true)

i_ranges = lines.select { |line| line.include?('-') }
                .map { |line| Range.new(*line.split('-').map(&:to_i)) }

merged_ranges = i_ranges.sort_by(&:min).each_with_object([]) do |range, acc|
  if acc.empty? || acc.last.max < range.min
    acc << range
  else
    acc[-1] = Range.new(acc.last.min, [acc.last.max, range.max].max)
  end
end

p merged_ranges.map(&:size).sum
