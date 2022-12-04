require 'pry'
require 'pry-nav'
require './input_2.rb'

def badges_priority_sum(input)
  rucksacks = input.split("\n")
  rucksack_items = ('a'..'z').to_a + ('A'..'Z').to_a

  badge_items = rucksacks.each_slice(3).map do |group_rucksacks|
    group_rucksacks.map! { |rucksack| rucksack.split('') }
    group_rucksacks[0] & group_rucksacks[1] & group_rucksacks[2]
  end

  sum = badge_items.map {|item| rucksack_items.index(item[0]) + 1 }.sum
  puts "Sum of priorities of badge items is: #{sum}"
end

badges_priority_sum(INPUT_2)
