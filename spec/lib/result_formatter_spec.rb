# frozen_string_literal: true

require 'rspec'
require_relative '../../app/lib/result_formatter'

describe ResultFormatter do
  let(:pair) do
    instance_double(
      'Pair',
      employee1: 1,
      employee2: 2,
      projects: { 1 => 16, 2 => 16 },
      total_days: 32
    )
  end

  describe '.format' do
    it 'formats the pair correctly' do
      expected_result = "Employees 1 and 2 worked together the longest for a total of 32 days.\n"\
                        "Project ID: 1, Days worked: 16\n"\
                        'Project ID: 2, Days worked: 16'
      expect(described_class.format(pair)).to eq(expected_result)
    end
  end
end
