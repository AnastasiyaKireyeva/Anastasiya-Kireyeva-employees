# frozen_string_literal: true

# class for file validations
class FileValidator
  class NoFileError < StandardError; end
  class EmptyFileError < StandardError; end

  def initialize(file_path)
    @file_path = file_path
  end

  def validate_file!
    raise NoFileError unless File.exist?(@file_path)
    raise EmptyFileError if File.empty?(@file_path)
  end
end
