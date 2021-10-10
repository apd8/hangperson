class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
  end

  def initialize(new_word) 
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def word
    @word
  end

  def guesses
    @guesses
  end

  def wrong_guesses
    @wrong_guesses
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(char)

    if char != nil
      new_char = char.downcase
    end

    if new_char.nil? or /[^A-Za-z]/.match(new_char) != nil or new_char == ''
      raise ArgumentError.new("Not a valid letter")
    end
    
    if @guesses.include? new_char or @wrong_guesses.include? new_char
      return false
    end
    
    if @word.include? new_char
      @guesses = @guesses + new_char
      return true
    else
      @wrong_guesses = @wrong_guesses + new_char
      return true
    end
  end

  def word_with_guesses
    @word.gsub(/[^ #{@guesses}]/, '-')
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    end
    
    if word_with_guesses == @word
      return :win
    end
    
    :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
