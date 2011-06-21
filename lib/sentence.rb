module NLP
  class Sentence

    attr_reader :tokens

    def initialize()
      @tokens = []
    end

    def << tokens
      if tokens.is_a? Array
        @tokens.concat tokens
      else
        @tokens << tokens
      end
      self
    end

    def words_number
      @tokens.count{|t| !t.interp?}
    end

  end
end
