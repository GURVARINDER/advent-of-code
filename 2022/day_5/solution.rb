require 'pry'
require 'pry-nav'
require 'benchmark'

def crates_on_top_part_1
  crates, stacks, instructions = formatted_input

  instructions.each do |i|
    move, from, to = i.map(&:to_i)
    move.to_i.times { stacks[to-1].unshift(stacks[from-1].delete_at(0)) }
  end

  puts "Part 1 answer: #{stacks.map {|v| v[0]}.join}"
end

def crates_on_top_part_2
  crates, stacks, instructions = formatted_input

  instructions.each do |i|
    move, from, to = i.map(&:to_i)
    stacks[to-1].unshift(stacks[from-1].shift(move))
    stacks[to-1] = stacks[to-1].flatten
  end

  puts "Part 2 answer: #{stacks.map {|v| v[0]}.join}"
end

def formatted_input
  input = File.open('input.txt')
  input = input.readlines.map(&:chomp)

  crates = input[0..input.index('')-2]
  instructions = input[input.index('')+1..-1].map! { |i| i.scan(/\d+/) }
  stack_nums = input[input.index('')-1]
  stacks = build_stacks(stack_nums: stack_nums, crates: crates)

  return crates, stacks, instructions
end

def build_stacks(stack_nums:, crates:)
  stacks = []
  stack_nums[-1].to_i.times { stacks << [] }

  stack_nums.gsub(' ', '').chars.each do |stack_num|
    crates.each do |crate|
      crate_code = crate[stack_nums.index(stack_num)]
      stacks[stack_num.to_i - 1] << crate_code unless [' ', nil].include?(crate_code)
    end
  end

  stacks
end

crates_on_top_part_1
crates_on_top_part_2
