class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(char)
    if char !~ /^[a-zA-Z]$/
      raise ArgumentError
    end
    if @guesses.include? char.downcase or @wrong_guesses.include? char.downcase
      return false
    end
    if @word.include? char.downcase
      @guesses +=char.downcase
      
    else
      @wrong_guesses +=char.downcase
    end
    return true
  end
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  def word_with_guesses
    result = ""
    @word.split("").each do |char|
      if @guesses.include? char
        result += char
      else
        result += "-"
      end
    end
    return result
  end
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    end
    @word.split("").each do |char|
      if ! @guesses.include? char
        return :play
      end
    end
    return :win
  end
end
