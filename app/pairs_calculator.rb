# frozen_string_literal: true

require 'csv'
require_relative 'date_parser'
require_relative 'pair'

# Main class for calculating
class PairsCalculator
  attr_reader :file_path

  def initialize(file_path:)
    @file_path = file_path
  end

  def calculate_pairs
    pairs = build_pairs
    longest_pair = pairs.max_by(&:total_days)
    format_result(longest_pair)
  end

  private

  def build_pairs
    pairs = []
    grouped_data.each do |project_id, employees|
      add_project_to_pairs(pairs, project_id, employees)
    end
    pairs
  end

  def grouped_data
    read_data_from_csv.group_by { |row| row['ProjectID'] }
  end

  def read_data_from_csv
    CSV.read(file_path, headers: true)
  end

  def add_project_to_pairs(pairs, project_id, employees)
    employees.combination(2) do |employee1, employee2|
      pair = find_or_create_pair(employee1['EmpID'], employee2['EmpID'], pairs)
      pair.add_project(project_id, calculate_days(employee1, employee2))
    end
  end

  def find_or_create_pair(employee1_id, employee2_id, pairs)
    pair = pairs.find { |p| p.employee1 == employee1_id && p.employee2 == employee2_id }
    pair || create_pair(employee1_id, employee2_id, pairs)
  end

  def create_pair(employee1_id, employee2_id, pairs)
    new_pair = Pair.new(employee1_id, employee2_id)
    pairs << new_pair
    new_pair
  end

  def calculate_days(employee1, employee2)
    start_date = [DateParser.parse(employee1['DateFrom']), DateParser.parse(employee2['DateFrom'])].max
    end_date = [DateParser.parse(employee1['DateTo']), DateParser.parse(employee2['DateTo'])].min
    end_date >= start_date ? (end_date - start_date).to_i : 0
  end

  def format_result(pair)
    return 'No pairs found.' unless pair

    projects_info = pair.projects.map { |project_id, days| "\nProject ID: #{project_id}, Days worked: #{days}" }.join
    "Employees #{pair.employee1} and #{pair.employee2} worked together the " \
    "longest for a total of #{pair.total_days} days.#{projects_info}"
  end
end
