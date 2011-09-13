require 'helper'

class TokenScannerTest < Test::Unit::TestCase

  def setup
    sentence = "To, jest zdanie." 
    @text = Lemmatizer.lemmatize(sentence,:takipi,:local)
    @scanner = TokenScanner.new(@text)

    sentence2 = "Ja byłam wtedy bardzo szczęśliwa" 
    @text2 = Lemmatizer.lemmatize(sentence2,:takipi,:local)
    @scanner2 = TokenScanner.new(@text2)
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


    assert_equal "Ja", @scanner2.current.orth
    @scanner2.next(:word)
    assert_equal "była", @scanner2.current.orth
    @scanner2.next(:word)
    assert_equal "wtedy", @scanner2.current.orth
    @scanner2.next(:word)
    @scanner2.next(:word)
    assert_equal "szczęśliwa", @scanner2.current.orth
    @scanner2.next(:word)
    assert @scanner2.end?
    @scanner2.rewind
    assert_equal 0, @scanner2.index
  end

end

