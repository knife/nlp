require 'inflectable'
module NLP
class Token
   attr_reader :orth
   attr_reader :tags

    
    def initialize(orth,tags)
        @orth = orth
        @tags = tags
    end

    def interp?
        @tags.eql? "interp"
    end

    def word?
        not interp? and not number?
    end

    def number?
        @tags.include?("tnum")
    end

    def integer?
        @tags.include?("tnum:integer")
    end

    def float?
        @tags.include?("tnum:frac")
    end


end
end
