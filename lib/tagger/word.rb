module NLP
  class Word < Token
    
    include Inflectable
    include Meaningable

    attr_reader :lemat
    attr_accessor :category

    def initialize(word, lemat, tags)
      super(word,tags)
      @lemat = lemat
    end

    def inflection
      @tags
    end

  end
end
