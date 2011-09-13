require 'helper'

class SentenceTest < Test::Unit::TestCase

  include NLP

  def setup 
    @sentence = Sentence.new
    @comma = Token.new(',','interp')
    @integer = Token.new('32','tnum:integer')
    @float = Token.new('3,12','tnum:frac')
    @symbol = Token.new('nie_istniejace_slowo','tsym')
  end


  def test_sentence_size
    assert_equal 0, @sentence.words_number
    @sentence << @symbol
    assert_equal 1, @sentence.words_number
    @sentence << @integer << @comma << @float 
    assert_equal 3, @sentence.words_number
  end

    
end
