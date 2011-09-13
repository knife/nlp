module NLP
  class TokenScanner

    attr_reader :text, :tokens

    def initialize(text)
      @text = text
      @pos = 0
      @tokens = @text.flatten
    end

    def next(type)
      @pos+=1

      case type
      when :word
        while @pos < @tokens.size and !@tokens[@pos].word?
          @pos+= 1
        end

      when :interp
        while @pos < @tokens.size and !@tokens[@pos].interp?
          @pos+= 1
        end

      when :number
        while @pos < @tokens.size and !@tokens[@pos].number?
          @pos+= 1
        end
      when :alphanum
        while @pos < @tokens.size and !@tokens[@pos].number? and !@tokens[@pos].word?
          @pos+= 1
        end
      end
    end

    def current 
      if @pos == @tokens.size
        nil
      else
        @tokens[@pos]
      end
    end

    def rewind
      @pos = 0
    end

    def index
      @pos
    end

    def end?
      @pos == tokens.size
    end
    
  end
end
