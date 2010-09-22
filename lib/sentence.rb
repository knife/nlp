module NLP
    class Sentence
        attr_reader :tokens
        def initialize()
            @tokens = []
        end

        def << tokens
            @tokens.concat tokens
        end

        def words_number
            @tokens.size
        end
    end
end
