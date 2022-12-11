require 'pry'
require 'pry-nav'
require './input_1.rb'

def misplaced_items_priority_sum(input)
  rucksacks = input.split("\n")
  rucksack_items = ('a'..'z').to_a + ('A'..'Z').to_a

  rucksacks.map! { |rucksack| rucksack.chars.each_slice(rucksack.size/2).map(&:join) }

  misplaced_items = rucksacks.map do |rucksack|
    compartment1 = rucksack[0].split('')
    compartment2 = rucksack[1].split('')
    compartment1 & compartment2
  end

  sum = misplaced_items.map {|item| rucksack_items.index(item[0]) + 1 }.sum

  puts "Misplaced item priorites sum: #{sum}"
end

misplaced_items_priority_sum(INPUT_1)
