# frozen_string_literal: true

def dist(point_a, point_b)
  point_a.zip(point_b).sum { |a, b| (a - b)**2 }
end

jbox = File.readlines('input.txt', chomp: true).map do |line|
  line.split(',').map(&:to_i)
end

jbox_pairs = []
(0...jbox.size).each do |i|
  ((i + 1)...jbox.size).each do |j|
    jbox_pairs << [i, j]
  end
end

jbox_pairs.each do |pair|
  pair << dist(jbox[pair[0]], jbox[pair[1]])
end.sort_by! { |pair| pair[2] }

circuits = jbox.size.times.map { |i| Set.new([i]) }
jbox_pairs.map { |e| e[..-2] }.each do |pair|
  point_a, point_b = pair

  circuit_a = circuits.find { |circuit| circuit.include?(point_a) }
  circuit_b = circuits.find { |circuit| circuit.include?(point_b) }

  next if circuit_a.equal?(circuit_b)

  circuit_a.merge(circuit_b)
  circuits.delete(circuit_b)

  if circuits.size == 1
    puts "result: #{jbox[pair[0]][0]}*#{jbox[pair[1]][0]}=#{jbox[pair[0]][0]*jbox[pair[1]][0]}"
  end
end
