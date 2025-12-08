# frozen_string_literal: true
def dist(a, b)
  (a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2 + (a[2] - b[2]) ** 2
end

jbox = File.readlines('input_test.txt', chomp: true).map do |line|
  line.split(',').map(&:to_i)
end

jbox_pairs = []
(0...jbox.size).to_a.product((0...jbox.size).to_a).each do |a, b|
  if a != b && (not jbox_pairs.include?([a, b].sort))
    jbox_pairs << [a, b].sort
  end
end

jbox_pairs.each do |pair|
  pair << dist(jbox[pair[0]], jbox[pair[1]])
end.sort_by! { |pair| pair[2] }

circuits = []
(0..9).each do |i|
  found = false
  jbox_pair = jbox_pairs[i][..-2]
  circuits_idx = []
  circuits.each_with_index do |circuit, i|
    if circuit.include?(jbox_pair[0]) || circuit.include?(jbox_pair[1])
      circuit.merge(jbox_pair)
      circuits_idx << i
      found = true
    end
  end

  if found
    sett = Set.new
    circuits_idx.each do |i|
      sett.merge(circuits[i])
    end
    circuits_idx.each do |i|
      circuits.delete_at(i)
    end

    sett.merge(jbox_pair)

    circuits << sett
  else
    circuits << jbox_pairs[i][..-2].to_set
  end
end

# jbox_pairs.each { |pair| p pair }

p circuits.sort_by(&:size).reverse.take(3).map(&:size).reduce(:*)
