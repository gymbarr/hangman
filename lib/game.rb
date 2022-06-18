class Game
  attr_reader :word_letters, :status, :errors, :opened_letters, :status

  def initialize(word)
    @errors = 0
    @opened_letters = []
    @used_letters = []
    @status = 0
    @word_letters = split_word(word)
  end

  def split_word(word)
    # filling the empty hidden_word array with _ corresponding to the number of letter in guessed word
    word.length.times do
      @opened_letters << '_'
    end

    word.split("")
  end

  def ask_next_letter
    # entering the letter
    # next we check the input to be sure it is correct
    while true
      print "Enter the letter: "
     entered_letter = $stdin.gets.chomp.downcase

      # check the intput for correct length
      if entered_letter.length == nil || entered_letter.length > 1
        puts "The input must consist of 1 letter!"
        next
     end

      # check the input for alphabetical letter
      if not entered_letter.match?(/[a-zа-я]/)
        puts "The input must consist of alphabetical character only!"
        next
     end

      # chek if the letter has been entered before
      if @used_letters.include?(entered_letter)
        puts "You've already entered this letter!"
        next
      end

     @used_letters << entered_letter
      break
   end

    check_letter(entered_letter)
  end

  # checking the entered letter for entrance in guessed word
  def check_letter(letter)
    # return if the game has ended
    if @status == -1 || @status == 1
      return
    end

    # check whether the guessed word include the entered letter
    if @word_letters.include?(letter)
      # if include then open this all this letters in the hidden word
      # replace all this letters in guessed word with '_' sign
      for i in (0...@word_letters.size)
        # @word_letters[i], @opened_letters[i] = @opened_letters[i], @word_letters[i] if @word_letters[i] == letter
        @opened_letters[i] = @word_letters[i] if @word_letters[i] == letter
      end
    else
      # decrease attempts counter if there is no such letter
      @errors += 1
    end

    # maximum attempts number is 7. when there are no attempts, the game ends
    if @errors >= 7
      @status = -1
    end

    # when all the letters were opened we turn on win flag
    if !@opened_letters.include?('_')
      @status = 1
    end
  end
end
