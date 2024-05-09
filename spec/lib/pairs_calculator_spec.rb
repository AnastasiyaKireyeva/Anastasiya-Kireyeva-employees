# frozen_string_literal: true

require 'rspec'
require_relative '../../app/lib/pairs_calculator'

describe PairsCalculator do
  let(:file_path) { 'spec/fixtures/test_data.csv' }
  subject(:employee_project) { described_class.new(file_path: file_path) }
  let(:expected_result) do
    "Employees 1 and 2 worked together the longest for a total of 32 days.\n"\
    "Project ID: 1, Days worked: 16\n"\
    'Project ID: 2, Days worked: 16'
  end

  describe '#calculate_pairs' do
    context 'when the file contains data for a single employee' do
      let(:file_path) { 'spec/fixtures/single_employee_data.csv' }

      it 'returns a message that no pairs were found' do
        expect(employee_project.calculate_pairs).to eq('No pairs found.')
      end
    end

    context 'when the file contains data for multiple employees but none of them worked together' do
      let(:file_path) { 'spec/fixtures/no_pairs_data.csv' }

      it 'returns a message that no pairs were found' do
        expect(employee_project.calculate_pairs).to eq('No pairs found.')
      end
    end

    context 'when the file contains data for multiple pairs' do
      let(:file_path) { 'spec/fixtures/multiple_pairs_data.csv' }
      let(:expected_result) do
        "Employees 1 and 2 worked together the longest for a total of 32 days.\n"\
        "Project ID: 1, Days worked: 16\n"\
        'Project ID: 2, Days worked: 16'
      end

      it 'returns the pair of employees who worked together the longest' do
        expect(employee_project.calculate_pairs).to eq(expected_result)
      end
    end
  end
end
