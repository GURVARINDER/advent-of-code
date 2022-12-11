require 'pry'
require 'pry-nav'
require './input'

def calculate_score_part_1(input)
  my_moves = 'XYZ'

  my_winning_combination = ['CX', 'AY', 'BZ']
  my_draw_combination = ['AX', 'BY', 'CZ']
  my_score = 0

  rounds = input.split("\n")

  rounds.each do |moves|
    moves.gsub!(' ', '')
    my_move = moves[1]

    my_score += my_moves.index(my_move) + 1
    my_score += 6 if my_winning_combination.include?(moves)
    my_score += 3 if my_draw_combination.include?(moves)
  end

  puts "Day 2 Solution 1: My total score would be: #{my_score}"
end

def calculate_score_part_2(input)
  # Using the following map to get my move score based on the round outcome
  # and the opponent's move e.g If round outcome is "X" (i.e lose) and opponent's
  # move is 'B'(i.e paper) then I can get my move's score using:
  # outcome_to_move_score_map['X']['B'] = 1
  outcome_to_move_score_map = {
    'X' => { 'A' => 3, 'B' => 1, 'C' => 2 }, # I lose
    'Y' => { 'A' => 1, 'B' => 2, 'C' => 3 }, # draw
    'Z' => { 'A' => 2, 'B' => 3, 'C' => 1 }  # I win
  }

  outcome_score_map = { 'X' => 0, 'Y' => 3, 'Z' => 6 }

  my_score = 0

  rounds = input.split("\n")

  rounds.each do |moves|
    opponent_move = moves[0]
    round_outcome = moves[2]

    my_score += outcome_score_map[round_outcome]
    my_score += outcome_to_move_score_map[round_outcome][opponent_move]
  end

  puts "Day 2 Solution 2: My total score would be: #{my_score}"
end

calculate_score_part_1(INPUT)
calculate_score_part_2(INPUT)
