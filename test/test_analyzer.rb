require 'helper'

class AnalyzerTest < Test::Unit::TestCase

  def setup
    sample = "Ja byłam wtedy bardzo szczęśliwa. Teraz gotuję potrawy z dyni i banana." 
    @text = Lemmatizer.lemmatize(sample,:takipi,:local)
    @scanner = TokenScanner.new(@text)
    @rid_analyzer = Analyzer.new(:rid)
    @liwc_analyzer = Analyzer.new(:liwc)
    @stats = @rid_analyzer.analyze(@scanner)
  end

  def test_analyze
    stats = @stats
    assert_kind_of TextStatistics, stats

    assert_equal ["szczęśliwy", "teraz", "gotować", "dynia", "banan"], stats.words
    assert_equal ['teraz'], stats.cwords.map{|k,v| {k.name => v}}.inject({}){|e,h| h.merge(e)}[:CHWILA]
    assert_equal  1, stats.scores.map{|k,v| {k.name => v}}.inject({}){|e,h| h.merge(e)}[:POZYTYWNY_AFEKT]
    assert_equal 12, stats.total_words #agultynat
    assert_equal 5, stats.word_count
  end

  def test_hash
    stats = @stats
    stats[:long_words] = 12
    assert_equal 12, stats[:long_words]
  end

end

