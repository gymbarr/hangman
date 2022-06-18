require_relative "lib/game"
require_relative "lib/result_printer"
require_relative "lib/word_reader"

words_file_name = File.dirname(__FILE__) + '/data/words.txt'

reader = WordReader.new
word = reader.read_from_file(words_file_name)
game = Game.new(word)
drawing = ResultPrinter.new(game)

while game.status == 0 do
  game.ask_next_letter
  drawing.show_status
end
