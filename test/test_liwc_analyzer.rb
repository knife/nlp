require 'helper'

class LIWCAnalyzerTest < Test::Unit::TestCase


  def setup
    sample = "Ja byłam wtedy bardzo szczęśliwa. Mój chłopak był czuły w przeciwieństwie do znajomych." 
    @text = Lemmatizer.lemmatize(sample,:takipi,:local)
    @scanner = TokenScanner.new(@text)
    @liwc_analyzer = LIWCAnalyzer.new
    @stats = @liwc_analyzer.analyze(@scanner)
  end

  def test_analyze
    assert_kind_of TextStatistics, @stats
    #assert_equal ["bardzo", "szczęśliwy", "chłopak", "czuły", "w","znajomy"], @stats.words
    assert_equal ['bardzo'], @stats.cwords.map{|k,v| {k.name => v}}.inject({}){|e,h| h.merge(e)}["PEWNOŚĆ".to_sym]
    assert_equal  2, @stats.scores.map{|k,v| {k.name => v}}.inject({}){|e,h| h.merge(e)}[:PRZYJACIELE]
    assert_equal 13, @stats.total_words
    assert_equal 6, @stats.word_count
  end

 end


