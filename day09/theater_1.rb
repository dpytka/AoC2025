# frozen_string_literal: true

Pair = Struct.new(:x, :y) do
  def distance
    x.zip(y).map { |a, b| (a - b).abs + 1 }.reduce(:*)
  end
end

points = File.readlines('input.txt', chomp: true)
             .map { |line| line.split(',').map(&:to_i) }

sorted_pairs = (0...points.size).to_a.combination(2)
                                .map { |i, j| Pair.new(points[i], points[j]) }
                                .sort_by(&:distance).reverse

sorted_pairs.first.tap do |pair|
  p "#{pair.x},#{pair.y},#{pair.distance}"
end
