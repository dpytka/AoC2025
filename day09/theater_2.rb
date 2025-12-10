# frozen_string_literal: true
# WIP
Pair = Struct.new(:x, :y) do
  def distance
    x.zip(y).map { |a, b| (a - b).abs + 1 }.reduce(:*)
  end

  def corners
    k = [y[0], x[1]]
    l = [x[0], y[1]]
    p "#{x}:#{y}:#{k}:#{l}"
  end

  def inside(points)
    k = [y[0], x[1]]
    l = [x[0], y[1]]
    corners = [k, l].sort_by(&:first)
    if corners[0][0] <= corners[1][0] && corners[0][1] <= corners[1][1]
      p1 = points.index { |point| point[0] <= corners[0][0] && point[1] <= corners[0][1] }
      p2 = points.index { |point| point[0] >= corners[1][0] && point[1] >= corners[1][1] }
    else
      p1 = points.index { |point| point[0] <= corners[0][0] && point[1] >= corners[0][1] }
      p2 = points.index { |point| point[0] >= corners[1][0] && point[1] <= corners[1][1] }
    end
    return true if p1 && p2

    false
  end
end

points = File.readlines('input.txt', chomp: true)
             .map { |line| line.split(',').map(&:to_i) }

sorted_pairs = (0...points.size).to_a.combination(2)
                                .map { |i, j| Pair.new(points[i], points[j]) }
                                .sort_by(&:distance).reverse

sorted_pairs.each do |pair|
  p "#{pair.x},#{pair.y},#{pair.distance}"
  next unless pair.inside(points)

  pair.corners
  p pair.distance
  break
end
