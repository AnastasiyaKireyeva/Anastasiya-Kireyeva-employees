# frozen_string_literal: true

require 'date'

# Class for date parsing
class DateParser
  SUPPORTED_FORMATS = [
    '%m/%d/%Y',  # 01/31/2024
    '%m-%d-%Y',  # 01-31-2024
    '%d-%m-%Y',  # 31-01-2024
    '%d/%m/%Y',  # 31/01/2024
    '%Y/%m/%d',  # 2024/01/31'
    '%Y-%m-%d'   # 2024-01-31
  ].freeze

  def self.parse(date)
    return Date.today if date.nil? || date.strip.empty?

    SUPPORTED_FORMATS.each do |format|
      return Date.strptime(date, format)
    rescue ArgumentError
      next
    end

    raise "Invalid date format: #{date}."
  end
end
