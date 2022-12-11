require 'pry'
require 'pry-nav'
require './input.rb'

def solution1(input)
  visible_tree_heights = []
  edge_indices = [0, input[0].size-1]

  input.each_with_index do |row, row_index|
    row.chars.each_with_index do |height, column_index|
      if edge_indices.include?(column_index) || edge_indices.include?(row_index)
        visible_tree_heights << height
        next
      end

      left_max = row[0..column_index-1].split('').max
      right_max = row[column_index+1..-1].split('').max
      column_values = input.map {|row| row[column_index]}
      top_max = column_values[0..row_index-1].max
      bottom_max = column_values[row_index+1..-1].max

      max_heights = [left_max, right_max, top_max, bottom_max]
      if max_heights.any? { |h| h < height }
        visible_tree_heights << height
      end
    end
  end
  puts visible_tree_heights.flatten.count
end

def solution2(input)
  all_scenic_scores = []
  edge_indices = [0, input[0].size-1]

  input.each_with_index do |row, row_index|
    row.chars.each_with_index do |height, column_index|
      next if edge_indices.include?(column_index) || edge_indices.include?(row_index)

      scenic_score = 1

      left_range = row[0..column_index-1].split('').reverse.index { |v| v >= height }
      right_range = row[column_index+1..-1].split('').index { |v| v >= height }

      column = input.map {|row| row[column_index]}

      top_range = column[0..row_index-1].reverse.index { |v| v >= height }
      bottom_range = column[row_index+1..-1].index { |v| v >= height }

      scenic_score *= left_range ? (left_range+1) : column_index
      scenic_score *= right_range ? (right_range+1) : (row.size - column_index - 1)
      scenic_score *= top_range ? (top_range+1) : row_index
      scenic_score *= bottom_range ? (bottom_range+1) : (column.size - row_index - 1)

      all_scenic_scores << scenic_score
    end
  end
  puts all_scenic_scores.max
end

solution1(INPUT.split("\n"))
solution2(INPUT.split("\n"))
