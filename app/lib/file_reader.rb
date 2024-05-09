# frozen_string_literal: true

require_relative '../validations/file_validator'

# Class for file reading
class FileReader
  def initialize(file_path)
    @file_path = file_path
    FileValidator.new(file_path).validate_file!
  end

  def read_file
    data = []
    CSV.foreach(file_path, headers: true) do |row|
      data << row
    end
    data
  end

  private

  attr_reader :file_path
end
