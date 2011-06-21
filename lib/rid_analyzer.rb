module NLP

  class  RIDAnalyzer < Analyzer

    def initialize
      @dictionary = Dictionary.new(:rid)
    end

  end
end
