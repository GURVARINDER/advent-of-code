require 'pry'
require 'pry-nav'
require './input.rb'

def solution(input)
  cycle = 0
  x = 1
  crt_position = [0,0] #[row, column]
  sprite_middle_position = 1
  lit_positions = []

  input.each_with_index do |instruction, index|
    instruction_part1, instruction_part2 = instruction.split(' ')
    sprite_positions = [sprite_middle_position - 1, sprite_middle_position, sprite_middle_position + 1]

    if instruction_part2 # addX
      2.times do
        cycle += 1
        change_row_if_needed(cycle, crt_position)
        record_lit_positions(crt_position, sprite_positions, cycle, lit_positions)
        crt_position = move_crt(crt_position)
      end
      x += instruction_part2.to_i
      sprite_middle_position = x.dup
    else # noop
      cycle += 1
      change_row_if_needed(cycle, crt_position)
      record_lit_positions(crt_position, sprite_positions, cycle, lit_positions)
      crt_position = move_crt(crt_position)
    end
  end

  draw(lit_positions)
end

def draw(lit_positions)
  6.times do |row_no|
    drawing = ''
    40.times do |col_no|
      if lit_positions.include?([row_no, col_no])
        drawing += '#'
      else
        drawing += '.'
      end
    end
    puts drawing
  end
end

def get_drawing_row(current_cycle)
  (current_cycle/40.to_f).ceil - 1
end

def record_lit_positions(crt_position, sprite_positions, cycle, lit_positions)
  if sprite_positions.include?(crt_position[1])
    row = get_drawing_row(cycle)
    lit_positions << [row, crt_position[1]]
  end
end

def move_crt(crt_position)
  new_crt_position = [crt_position[0], crt_position[1] + 1]
end

def change_row_if_needed(cycle, crt_position)
  row = get_drawing_row(cycle)
  if row != crt_position[0] # check if crt needs to go to the next line
    crt_position[0] = row
    crt_position[1] = 0
  end
end

solution(INPUT.split("\n"))
