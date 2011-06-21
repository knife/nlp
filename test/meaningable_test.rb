require 'helper'
require '../lib/word.rb'

class MeaningableTest < Test::Unit::TestCase
  include NLP

  def setup 
    
    @word_kochamy = Word.new('kochamy','kochać', 'fin:pl:pri:imperf')
    psych_cat  = LIWCCategory.new('PROCESY_PSYCHOLOGICZNE')
    emotion_cat = LIWCCategory.new('EMOCJE',psych_cat)
    pos_emotion_cat = LIWCCategory.new('POZYTYWNE_EMOCJE',emotion_cat)
    @word_kochamy.category = pos_emotion_cat

  end

  def test_category_recognition

   assert @word_kochamy.psychological?
   assert @word_kochamy.positive_emotion?
   assert @word_kochamy.emotion?

   assert !@word_kochamy.negative_emotion?
  end


end

