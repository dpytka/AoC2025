# frozen_string_literal: true

def invalid(str)
  first = str[0, str.size / 2]
  second = str[str.size / 2..]

  str.to_i if first == second
end

result = File.read('input.txt')
             .split(',')
             .map { |el| Range.new(*el.split('-')) }
             .map do |r|
               r.map { |e| e if invalid(e) }.compact!
             end
             .flatten
             .map(&:to_i).sum

p result
