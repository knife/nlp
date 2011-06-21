require '../lib/analyzer.rb'


class AnalyzerTest < Test::Unit::TestCase

  include NLP

  def setup
    sample = "Ja byłam wtedy bardzo szczęśliwa" 
    @text = Lemmatizer.lemmatize(sample,:takipi,:local)
    @scanner = TokenScanner.new(@text)
    @rid_analyzer = Analyzer.new(:rid)
    @liwc_analyzer = Analyzer.new(:liwc)
  end

  def test_analyze
    stats = @rid_analyzer.analyze(@scanner) 
    assert_kind_of Statistic, stats
    assert_equal 5, stats.total_words
    assert_equal 1, stats.word_count

  end

end

