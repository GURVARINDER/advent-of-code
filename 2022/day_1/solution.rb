require 'pry'
require 'pry-nav'
require './input'

def highest_calorie_elf(input)
  calorie_totals = calorie_totals(input)
  puts "Day 1 Solution 1: Elf with highest calories has #{calorie_totals.max} calories"
end

def top_3_elf_highest_calories(input)
  calorie_totals = calorie_totals(input)
  puts "Day 2 Solution 2: Top 3 elves with highest calories have #{calorie_totals.max(3).sum} calories in total"
end

def calorie_totals(input)
  input.split("\n\n")
       .map { |value| value.split("\n").map(&:to_i).sum }
end

highest_calorie_elf(INPUT)
top_3_elf_highest_calories(INPUT)
