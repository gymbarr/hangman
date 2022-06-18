class ResultPrinter

  def initialize(game)
    @status_image = []
    @game = game

    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= 7 do
      file_name = current_path + "/../image/#{counter}.txt"

      if File.exist?(file_name)
        image_file = File.new(file_name, "r:UTF-8")
        @status_image << image_file.read
        image_file.close
      else
        @status_image << "\n [ image not found ] \n"
      end

      counter += 1
    end

    # we call this method to show hidden word at the begining
    show_status
  end

  # clears the screen
  def cls
    system "clear" or system "cls"
  end

  # output to the screen results after each entrered letter
  def show_status
    cls

    # show the hidden word with opened letters
    puts @game.opened_letters.to_s

    # drawing a hangman depend on the remain attempts
    puts @status_image[@game.errors]

    # show the final result to the user
    puts "You won!" if @game.status == 1
    if @game.status == -1
      puts "You lose!"
      puts "The guessed word is: #{@game.word_letters.join("")}"
    end
  end
end
