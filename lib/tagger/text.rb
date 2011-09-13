module NLP
  class Text
    attr_reader :sentences

    def initialize
      @sentences = []
    end

    def << sentence
      @sentences.push sentence
    end

    def words_per_sentence
      @sentences.collect{|s| s.words_number}.mean
    end

    def flatten
      flattened = []
      @sentences.each{ |s| s.tokens.each{|t| flattened.push t } }
      flattened
    end

  end
end
