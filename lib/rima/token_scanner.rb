class TokenScanner
  attr_reader :text, :tokens

    def initialize(text)
        @pos = 0
        @text = text
        @tokens = flatten_text(text)
    end

    def scan(type)

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
           
        end

        
        if @pos == @tokens.size
                nil
            else
                @pos+= 1
                @tokens[@pos-1]
            end


    end

    private 

    def flatten_text(text)
        flattened = []
        text.each { |s| s.tokens.each {|t| flattened.push t } }
        flattened
    end

end
