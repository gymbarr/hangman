class WordReader
  def read_from_file(filepath)
    if !File.exist?(filepath)
      abort "File not found."
    end

    words_file = File.new(filepath, "r:UTF-8")
    words = words_file.readlines
    words_file.close

    words.sample.chomp
  end
end
