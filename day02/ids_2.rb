# frozen_string_literal: true

def invalid(str)
  (1..(str.size / 2)).each do |pos|
    next if (str.size % pos).positive?

    x = 0.step(str.size, pos).map(&:to_i)

    return str.to_i if x[..-2].zip(x[1..])
                              .map { |el| Range.new(*el, true) }
                              .map { |el| str[el] }.uniq.size == 1
  end

  nil
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
