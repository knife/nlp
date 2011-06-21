require 'helper'
require '../lib/token.rb'

class TokenTest < Test::Unit::TestCase

  include NLP

  def setup 
    @comma = Token.new(',','interp')
    @integer = Token.new('32','tnum:integer')
    @float = Token.new('3,12','tnum:frac')
    @symbol = Token.new('nie_istniejace_slowo','tsym')
  end


  def test_recognizing_interpunction
    assert @comma.interp?
    assert !@comma.word?
  end

  def test_recognizing_numbers
    assert @integer.integer?
    assert !@integer.word?

    assert @float.float?
    assert @float.number?

    assert !@float.word?
    assert !@float.integer?
  end

  def test_symbol
    assert @symbol.symbol?
  end
    
    
end
