# frozen_string_literal: true

require 'tk'
require_relative 'pairs_calculator'

root = TkRoot.new { title 'Pairs Calculator' }
root.geometry('500x200')

result = TkVariable.new

image = TkPhotoImage.new(file: 'app/public/images/open-file.png')

button = TkButton.new(root, image: image) do
  command proc {
    file = Tk.getOpenFile
    pairs_calculator = PairsCalculator.new(file_path: file)
    calculation_result = pairs_calculator.calculate_pairs
    result.value = calculation_result
  }
end

label = TkLabel.new(root) do
  textvariable result
end

button.pack do
  padx 50
  pady 50
  side 'top'
end
label.pack do
  padx 50
  pady 50
  side 'top'
end

Tk.mainloop
