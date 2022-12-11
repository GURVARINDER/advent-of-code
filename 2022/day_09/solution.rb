require 'pry'
require 'pry-nav'
require './input.rb'

def solution(input:, number_of_knots:)
  head_knot = [0,0] #[row, column]
  body_knots = (number_of_knots-1).times.map{ [0,0] }
  positions_visited_by_tail = [[0,0]]

  input.each do |input|
    direction, steps = input.split(' ')

    steps.to_i.times do
      # move head knot
      case direction
      when 'R'
        head_knot[1] += 1
      when 'L'
        head_knot[1] -= 1
      when 'U'
        head_knot[0] += 1
      when 'D'
        head_knot[0] -= 1
      end

      leader_knot = head_knot

      # move all body knots one by one
      body_knots.size.times do |i|
        knot = body_knots[i]

        # if any body knot doesn't need to move, all subsequent knots would also not need to move
        break unless knot_needs_to_move?(knot: knot, leader_knot: leader_knot)

        if leader_knot[0] == knot[0] # same row
          # move knot 1 column closer to its leader
          knot[1] = leader_knot[1] > knot[1] ? knot[1]+1 : knot[1]-1
        elsif leader_knot[1] == knot[1] # same column
          # move knot 1 row closer to its leader
          knot[0] = leader_knot[0] > knot[0] ? knot[0]+1 : knot[0]-1
        else
          # move knot diagonally closer to its leader
          knot[0] = leader_knot[0] > knot[0] ? knot[0]+1 : knot[0]-1
          knot[1] = leader_knot[1] > knot[1] ? knot[1]+1 : knot[1]-1
        end
        body_knots[i] = knot.dup
        positions_visited_by_tail << knot.dup if i == body_knots.size - 1
        leader_knot = knot.dup
      end
    end
  end

  positions_visited_by_tail.uniq.size
end

def knot_needs_to_move?(knot:, leader_knot:)
  return false if leader_knot == knot # overlapped
  return false if leader_knot[0] == knot[0] && (leader_knot[1].abs - knot[1].abs).abs == 1 # same row and adjacent columns
  return false if leader_knot[1] == knot[1] && (leader_knot[0].abs - knot[0].abs).abs == 1 # same columns and adjacent rows
  return false if (leader_knot[1].abs - knot[1].abs).abs == 1 && (leader_knot[0].abs - knot[0].abs).abs == 1 # diagonally placed

  true
end

puts "Part 1 answer: #{solution(input: INPUT.split("\n"), number_of_knots: 2)}"
puts "Part 2 answer: #{solution(input: INPUT.split("\n"), number_of_knots: 10)}"
