# frozen_string_literal: true

require 'rspec'
require_relative '../../app/validations/file_validator'

describe FileValidator do
  let(:file_path) { 'path/to/file.csv' }
  subject { described_class.new(file_path) }

  describe '#validate_file!' do
    context 'when file does not exist' do
      before do
        allow(File).to receive(:exist?).with(file_path).and_return(false)
      end

      it 'raises NoFileError' do
        expect { subject.validate_file! }.to raise_error(FileValidator::NoFileError)
      end
    end

    context 'when file exists but is empty' do
      before do
        allow(File).to receive(:exist?).with(file_path).and_return(true)
        allow(File).to receive(:empty?).with(file_path).and_return(true)
      end

      it 'raises EmptyFileError' do
        expect { subject.validate_file! }.to raise_error(FileValidator::EmptyFileError)
      end
    end

    context 'when file exists and is not empty' do
      before do
        allow(File).to receive(:exist?).with(file_path).and_return(true)
        allow(File).to receive(:empty?).with(file_path).and_return(false)
      end

      it 'does not raise an error' do
        expect { subject.validate_file! }.not_to raise_error
      end
    end
  end
end
