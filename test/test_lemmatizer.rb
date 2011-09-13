require 'helper'

class LemmatizerTest < Test::Unit::TestCase

  include NLP

  def setup
    @sample = "Złe czasy już minęły."

    @zle_word = Word.new('złe','zły','adj:pl:nom:m3:pos')
    @czasy_word = Word.new('czasy','czas','subst:pl:nom:m3')
    @minely_word = Word.new('minęły','minąć','praet:pl:m3:perf')
    @juz_word = Word.new('już','już','qub')
    @period = Token.new('.','interp')
  end

  

  # def test_takipi_remote_lemmatizer
  #     text = Lemmatizer.lemmatize(@sample,:takipi,:remote)
  #     test_takipi_lemmatizer(text)
  # end


  def test_takipi_local_lemmatizer
    text = Lemmatizer.lemmatize(@sample,:takipi,:local)
    test_takipi_lemmatizer(text)
  end


  def test_morfeusz_leamtizer
    text = Lemmatizer.lemmatize(@sample)
    assert_equal Text, text.class
    assert_equal 1, text.sentences.size
    assert_equal 4, text.sentences[0].words_number
    
    tokens = text.sentences[0].tokens
    zle,czasy,juz,minely,period = *tokens
    assert_equal 'zły', zle.lemat
    assert_equal 'czas', czasy.lemat
    assert_equal 'już', juz.lemat
    assert_equal 'minąć', minely.lemat
  end

private
  def test_takipi_lemmatizer(text)
    assert_equal Text, text.class
    assert_equal 1, text.sentences.size
    assert_equal 4, text.sentences[0].words_number
    
    tokens = text.sentences[0].tokens
    zle, czasy, juz, minely, period = *tokens
    assert_equal @zle_word.inflection, zle.inflection 
    assert_equal @czasy_word.inflection, czasy.inflection
    assert_equal @juz_word.inflection, juz.inflection
    assert_equal @minely_word.inflection, minely.inflection
    assert_equal @period.tags, period.tags

    assert_equal 'zły', zle.lemat
    assert_equal 'czas', czasy.lemat
    assert_equal 'już', juz.lemat
    assert_equal 'minąć', minely.lemat
  end
end
