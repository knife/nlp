require 'helper'

class LIWCAnalyzerTest < Test::Unit::TestCase

  def setup
    @stats = TextStatistics.new 
  end

  def test_hash
    @stats[:long_words] = 12
    assert_equal 12, @stats[:long_words]
  end

end
