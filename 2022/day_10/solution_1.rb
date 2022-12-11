require 'pry'
require 'pry-nav'
require './input.rb'

def solution(input)
  cycles_of_interest = [20, 60, 100, 140, 180, 220]
  signal_strengths = []
  cycle = 0
  x = 1

  input.each_with_index do |instruction, index|
    cycle, x = apply_instruction(instruction, cycle, x)

    unless index == (input.size - 1)
      upcoming_cycle, _ = apply_instruction(input[index+1], cycle, x)
      cycle_of_interest = cycles_of_interest.find { |c| (cycle+1..upcoming_cycle).include?(c) }
      signal_strengths << x * cycle_of_interest if cycle_of_interest
    end
  end
  puts "Part 1 answer: #{signal_strengths.sum}"
end

def apply_instruction(instruction, current_cycle, current_x)
  instruction_part1, instruction_part2 = instruction.split(' ')

  if instruction_part2 # addX
    current_cycle += 2
    current_x += instruction_part2.to_i
  else # noop
    current_cycle += 1
  end

  return current_cycle, current_x
end

solution(INPUT.split("\n"))
