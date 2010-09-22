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
            mean(@sentences.collect{|s| s.words_number})
        end

        private
        def mean(x)
            sum=0
            x.each{|v| sum+=v }
            sum/x.size
        end
    end
end
