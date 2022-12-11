require 'set'
require 'pry'
require 'pry-nav'
require './input'

def pairs_fully_overlapping(input)
  elf_pairs = input_formatter(input)

  pairs_fully_overlapping = elf_pairs.filter do |p|
    set1 = Range.new(p[0][0].to_i, p[0][1].to_i).to_set
    set2 = Range.new(p[1][0].to_i, p[1][1].to_i).to_set
    set1.subset?(set2) || set2.subset?(set1)
  end

  puts "Assignment pairs fully overlapping: #{pairs_fully_overlapping.count}"
end

def pairs_partially_overlapping(input)
  elf_pairs = input_formatter(input)

  pairs_partially_overlapping = elf_pairs.filter do |p|
    list1 = Range.new(p[0][0].to_i, p[0][1].to_i).to_a
    list2 = Range.new(p[1][0].to_i, p[1][1].to_i).to_a

    (list1 - list2).size < list1.size
  end

  puts "Assignment pairs partially overlapping: #{pairs_partially_overlapping.count}"
end

def input_formatter(input)
  elf_pairs = input.split("\n")
  elf_pairs.map! do |elf_pair|
    elf_pair.split(",").map {|p| p.split('-')}
  end
end

pairs_fully_overlapping(INPUT)
pairs_partially_overlapping(INPUT)
