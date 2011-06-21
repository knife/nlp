require 'helper'
require '../lib/word.rb'

class WordTest < Test::Unit::TestCase
  include NLP

  def setup 
    @word_kota = Word.new('kota','kot','subst:sg:gen.acc:m2')
    @word_siebie = Word.new('siebie','się','siebie:gen.acc')
  end

  def test_word_lematization
    assert_equal 'kot', @word_kota.lemat 
    assert_equal 'się', @word_siebie.lemat
  end

  def test_word_orth
    assert_equal 'kota', @word_kota.orth
    assert_equal 'siebie', @word_siebie.orth
  end

  def test_recognizing_part_of_speech
    assert @word_kota.rzeczownik?
    assert @word_siebie.zaimek?
  end

  def test_recognizing_inflection
    assert @word_kota.liczba_pojedyncza?
    assert @word_kota.dopelniacz?
    assert @word_kota.biernik?
    assert @word_kota.meski_zwierzecy?

    assert !@word_kota.liczba_mnoga?
    assert !@word_kota.mianownik?

    assert @word_siebie.biernik?
    assert @word_siebie.dopelniacz?
  end

  def test_inflection_string
    assert_equal  @word_kota.inflection, 'subst:sg:gen.acc:m2'
  end


end
