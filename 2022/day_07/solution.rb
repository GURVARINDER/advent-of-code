require 'pry'
require 'pry-nav'
require './input.rb'

def solution(input)
  input = input.split("\n")
  directories = {}
  ls_indices = input.each_index.select { |i| input[i] == '$ ls' }.sort
  ls_indices.each_with_index do |ls_index, i|
    dir = input[ls_index-1].split(' ')[-1]
    dir_content = i == ls_indices.size - 1 ? input[ls_index+1..-1] : input[ls_index+1..ls_indices[i+1]-2]
    dir_content.delete('$ cd ..')
    directories[dir] = dir_content
  end
  binding.pry

  dir_sizes = find_dir_sizes(directories)
end

def find_leafs(directories)
  leafs = directories.select {|dir, dir_content| !dir_content.any?(/dir/) }
end

def find_dir_sizes(directories)
  dir_sizes = {}
  leafs = find_leafs(directories)
  parents = []

  leafs.each do |leaf_dir, leaf_contents|
    size = directories[leaf_dir].map {|c| c.split(' ')[0].to_i}.sum
    dir_sizes[leaf_dir] = size
    parents = find_calculable_parents(leaf_dir, dir_sizes, directories)
  end
end

def find_calculable_parents(leaf_dir, dir_sizes, directories)
  parents = directories.select do |dir, dir_contents|
    if dir_contents.include?("dir #{leaf_dir}")
      dir_contents.all? {|c| c.match(/dir/) && dir_sizes.include?(c.split(' ')[1]) || (!c.match(/dir/))}
    end
  end
end

solution(INPUT)