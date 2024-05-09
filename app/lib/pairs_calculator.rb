# frozen_string_literal: true

require 'csv'
require_relative 'date_parser'
require_relative 'pair'
require_relative 'file_reader'
require_relative 'result_formatter'

# Main class for calculating
class PairsCalculator
  attr_reader :file_path, :file_reader, :pairs

  def initialize(file_path:)
    @file_path = file_path
    @pairs = []
    @file_reader = FileReader.new(file_path)
  end

  def calculate_pairs
    build_pairs
    longest_pair = pairs.max_by(&:total_days)

    return 'No pairs found.' if longest_pair.nil? || longest_pair.total_days.zero?

    ResultFormatter.format(longest_pair)
  end

  private

  def build_pairs
    grouped_data.each do |project_id, employees|
      add_project_to_pairs(project_id, employees)
    end
  end

  def grouped_data
    file_reader.read_file.group_by { |row| row['ProjectID'] }
  end

  def add_project_to_pairs(project_id, employees)
    employees.combination(2) do |employee1, employee2|
      pair = find_or_create_pair(employee1['EmpID'], employee2['EmpID'])
      pair.add_project(project_id, calculate_days(employee1, employee2))
    end
  end

  def find_or_create_pair(employee1_id, employee2_id)
    pair = pairs.find { |p| p.employee1 == employee1_id && p.employee2 == employee2_id }
    pair || create_pair(employee1_id, employee2_id)
  end

  def create_pair(employee1_id, employee2_id)
    new_pair = Pair.new(employee1_id, employee2_id)
    pairs << new_pair
    new_pair
  end

  def calculate_days(employee1, employee2)
    start_date = [DateParser.parse(employee1['DateFrom']), DateParser.parse(employee2['DateFrom'])].max
    end_date = [DateParser.parse(employee1['DateTo']), DateParser.parse(employee2['DateTo'])].min
    end_date >= start_date ? (end_date - start_date).to_i : 0
  end
end
