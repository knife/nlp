require 'helper'
require '../lib/token.rb'

class TextTest < Test::Unit::TestCase

  include NLP

  def setup 
    @s1 = Sentence.new
    @s2 = Sentence.new
    @comma = Token.new(',','interp')
    @integer = Token.new('32','tnum:integer')
    @float = Token.new('3,12','tnum:frac')
    @symbol = Token.new('nie_istniejace_slowo','tsym')
    @s1 << @integer << @comma << @symbol
    @s2 << @integer << @symbol
    @text = Text.new

  end


  def test_text
    @text << @s1 
    @text << @s2
    assert_equal 2, @text.words_per_sentence
  end

    
end
