require 'pry'
require 'pry-nav'
require './input.rb'

def monkey_business(input:, problem_part:)
  input = input.split("\n\n").map { |i| i.split("\n") }
  monkeys = {}
  monkey_inspection_count = 8.times.map { [] }
  rounds = problem_part == 1 ? 20 : 10000

  input.each_with_index do |monkey, monkey_index|
    monkeys["monkey_#{monkey_index}"] = {}
    monkey.each_with_index do |info, info_index|
      case info_index
      when 1
        monkeys["monkey_#{monkey_index}"]['items'] = info.split(': ')[1].split(',').map(&:to_i)
      when 2
        operator, number = info.split('old ')[1].split(' ')
        monkeys["monkey_#{monkey_index}"]['operation'] = {}
        monkeys["monkey_#{monkey_index}"]['operation']['operator'] = operator
        monkeys["monkey_#{monkey_index}"]['operation']['number'] = number.to_i
      when 3
        monkeys["monkey_#{monkey_index}"]['test'] = {}
        monkeys["monkey_#{monkey_index}"]['test']['divisible_by'] = info.split('by ')[1].to_i
        monkeys["monkey_#{monkey_index}"]['test']['throw_to_monkey_if_true'] = monkey[info_index + 1].split('monkey ')[1]
        monkeys["monkey_#{monkey_index}"]['test']['throw_to_monkey_if_false'] = monkey[info_index + 2].split('monkey ')[1]
        break
      end
    end
  end

  rounds.times do |round|
    monkeys.each do |monkey, monkey_info|
      operator, number = monkey_info['operation'].values
      divisible_by = monkey_info['test']['divisible_by']

      monkey_inspection_count[monkey[-1].to_i] << monkey_info['items'].size
      monkey_info['items'].each do |item|
        worry_level = number == 0 ? item.send(operator.to_s, item) : item.send(operator.to_s, number)
        worry_level = (worry_level / 3.to_f).floor if problem_part == 1
        worry_level = truncated_worry_level(worry_level) if problem_part == 2
        throw_to_monkey = worry_level % divisible_by == 0 ? monkey_info['test']['throw_to_monkey_if_true'] : monkey_info['test']['throw_to_monkey_if_false']

        monkeys["monkey_#{throw_to_monkey}"]['items'] << worry_level
      end

      monkey_info['items'] = []
    end
  end
  monkey_inspection_count.map! { |counts| counts.sum }

  puts "Part #{problem_part} answer: #{monkey_inspection_count.sort.reverse.take(2).inject(:*)}"
end

def truncated_worry_level(worry_level)
  p = 2*7*13*19*11*5*3*17
  worry_level = (worry_level % p == 0) ? p : (worry_level % p)
end

monkey_business(input: INPUT, problem_part: 1)
monkey_business(input: INPUT, problem_part: 2)
