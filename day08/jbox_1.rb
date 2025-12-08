# frozen_string_literal: true

require 'set'

def dist(point_a, point_b)
  point_a.zip(point_b).sum { |a, b| (a - b)**2 }
end

connections = 1000
jbox = File.readlines('input.txt', chomp: true)
                .map { |line| line.split(',').map(&:to_i) }

jbox_pairs = (0...jbox.size).to_a.combination(2)
                                .map { |i, j| [i, j, dist(jbox[i], jbox[j])] }
                                .sort_by { |pair| pair[2] }

circuits = jbox.size.times.map { |i| Set.new([i]) }
jbox_pairs.first(connections).map { |pair| pair.take(2) }.each do |point_a, point_b|
  circuit_a = circuits.find { |circuit| circuit.include?(point_a) }
  circuit_b = circuits.find { |circuit| circuit.include?(point_b) }

  next if circuit_a.equal?(circuit_b)

  circuit_a.merge(circuit_b)
  circuits.delete(circuit_b)
end

p circuits.sort_by(&:size).reverse.first(3).map(&:size).reduce(:*)
