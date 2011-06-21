require 'helper'
require '../lib/token_scanner.rb'

class TokenScannerTest < Test::Unit::TestCase

  include NLP

  def setup
    sentence = "To, jest zdanie." 
    @text = Lemmatizer.lemmatize(sentence,:takipi,:local)
    @scanner = TokenScanner.new(@text)

  end

  def test_scanner
    assert_equal "To", @scanner.current.orth
    @scanner.next(:word)
    assert_equal "jest", @scanner.current.orth
    @scanner.next(:interp)
    assert_equal ".", @scanner.current.orth
    @scanner.next(:word)
    assert @scanner.end?
    @scanner.rewind
    assert_equal 0, @scanner.index
  end

end

