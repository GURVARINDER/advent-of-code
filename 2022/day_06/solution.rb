require 'pry'
require 'pry-nav'
require './input.rb'

def chars_before_first_packet(input)
  puts "Part 1 answer: #{chars_before(entity_size: 4, input: input)}"
end

def chars_before_first_message(input)
  puts "Part 2 answer: #{chars_before(entity_size: 14, input: input)}"
end

def chars_before(entity_size:, input:)
  chars_before = 0

  input.each_with_index do |_, index|
    break if index > (input.size - entity_size)
    if input[index..index + entity_size - 1].uniq.size == input[index..index + entity_size - 1].size
      chars_before = index + entity_size
      break
    end
  end

  chars_before
end

chars_before_first_packet(INPUT.chars)
chars_before_first_message(INPUT.chars)