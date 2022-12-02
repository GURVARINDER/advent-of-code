require 'pry'
require 'pry-nav'
require './day_1_input'

def highest_calorie_elf(input)
  calorie_totals = calorie_totals(input)
  puts "Day 1 Solution 1: Elf with highest calories has #{calorie_totals.sort.last} calories"
end

def top_3_elf_highest_calories(input)
  calorie_totals = calorie_totals(input)
  puts "Day 2 Solution 2: Top 3 elves with highest calories have #{calorie_totals.sort.reverse.take(3).sum} calories in total"
end

def calorie_totals(input)
  input = input.split("\n\n")
  totals = []
  input.each_with_index { |value, index| totals[index] = value.split("\n").map(&:to_i).sum }
  totals
end

highest_calorie_elf(DAY_1_INPUT)
top_3_elf_highest_calories(DAY_1_INPUT)
