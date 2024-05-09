# frozen_string_literal: true

require_relative '../../app/lib/date_parser'
require 'date'

RSpec.describe DateParser, '#parse' do
  context 'when the date is present' do
    it 'parses dates in the format mm/dd/yyyy' do
      expect(DateParser.parse('01/31/2024')).to eq(Date.new(2024, 1, 31))
    end

    it 'parses dates in the format mm-dd-yyyy' do
      expect(DateParser.parse('01-31-2024')).to eq(Date.new(2024, 1, 31))
    end

    it 'parses dates in the format dd-mm-yyyy' do
      expect(DateParser.parse('31-01-2024')).to eq(Date.new(2024, 1, 31))
    end

    it 'parses dates in the format dd/mm/yyyy' do
      expect(DateParser.parse('31/01/2024')).to eq(Date.new(2024, 1, 31))
    end

    it 'parses dates in the format yyyy/mm/dd' do
      expect(DateParser.parse('2024/01/31')).to eq(Date.new(2024, 1, 31))
    end

    it 'parses dates in the format yyyy-mm-dd' do
      expect(DateParser.parse('2024-01-31')).to eq(Date.new(2024, 1, 31))
    end
  end

  context 'when the date string is nil' do
    it 'returns today\'s date' do
      expect(DateParser.parse(nil)).to eq(Date.today)
    end
  end

  context 'when the date string is empty' do
    it 'returns today\'s date' do
      expect(DateParser.parse('')).to eq(Date.today)
    end
  end

  context 'when the date format is invalid' do
    it 'raises an error' do
      expect { DateParser.parse('invalid date') }.to raise_error('Invalid date format: invalid date.')
    end
  end
end
