# frozen_string_literal: true

require 'set'

# Calculate squared Euclidean distance between two 3D points
def squared_distance(point_a, point_b)
  point_a.zip(point_b).sum { |a, b| (a - b)**2 }
end

# Read and parse input data
def read_jbox_data(filename)
  File.readlines(filename, chomp: true)
      .map { |line| line.split(',').map(&:to_i) }
end

# Generate all possible pairs with their distances
def generate_pairs_with_distances(jbox_data)
  (0...jbox_data.size).to_a.combination(2).map do |i, j|
    [i, j, squared_distance(jbox_data[i], jbox_data[j])]
  end.sort_by { |pair| pair[2] }
end

# Check if a pair connects to existing circuits
def find_connecting_circuits(pair, circuits)
  pair_set = pair.to_set
  connecting_circuits = []
  
  circuits.each_with_index do |circuit, index|
    next if circuit.empty?
    
    if (pair_set - circuit).empty?
      # Both points already in this circuit
      return :already_connected, []
    elsif (pair_set - circuit).size == 1
      # One point connects to this circuit
      connecting_circuits << index
    end
  end
  
  return connecting_circuits.empty? ? :no_connection : :merge_circuits, connecting_circuits
end

# Merge circuits with a new pair
def merge_circuits(circuits, circuit_indices, pair)
  new_circuit = Set.new(pair)
  
  circuit_indices.each do |index|
    new_circuit.merge(circuits[index])
    circuits[index] = Set.new
  end
  
  circuits << new_circuit
  circuits.reject!(&:empty?)
end

# Build circuits by connecting pairs
def build_circuits(pairs, max_connections)
  circuits = []
  connections_made = 0
  
  pairs.each do |pair|
    pair_indices = pair[0..1]
    connection_type, circuit_indices = find_connecting_circuits(pair_indices, circuits)
    
    case connection_type
    when :already_connected
      next
    when :no_connection
      circuits << Set.new(pair_indices)
    when :merge_circuits
      merge_circuits(circuits, circuit_indices, pair_indices)
    end
    
    connections_made += 1
    break if connections_made >= max_connections
  end
  
  circuits
end

# Calculate the result based on the three largest circuits
def calculate_result(circuits)
  largest_circuits = circuits.sort_by(&:size).reverse.take(3)
  largest_circuits.map(&:size).reduce(:*)
end

# Main execution
def main
  max_connections = 10
  input_file = 'input_test.txt'
  
  jbox_data = read_jbox_data(input_file)
  pairs_with_distances = generate_pairs_with_distances(jbox_data)
  circuits = build_circuits(pairs_with_distances, max_connections)
  
  result = calculate_result(circuits)
  
  puts "Wynik to: #{result}"
  
  # Display the three largest circuits for debugging
  largest_circuits = circuits.sort_by(&:size).reverse.take(3)
  puts "Three largest circuits: #{largest_circuits}"
  puts "Their sizes: #{largest_circuits.map(&:size)}"
end

# Run the program
main if __FILE__ == $0
