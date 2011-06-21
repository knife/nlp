require 'meaningable'

module NLP
  class Emoticon < Token
    include Meaningable

    def initialize(tokens,tags)
      @orth = tokens.join("")
      @tags = 'emoticon'           
    end

  end
end

