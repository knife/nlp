module NLP

    class LIWCCategory < Category

	#primary categories
      
       def linguistic?
          root == :PIERWOTNE
        end
        
        def psychological?
          root == :PROCESY_PSYCHOLOGICZNE
        end

        
        def relative?
            root === :RELATYWNOSC
        end
        
        def personal?
          root == :OSOBISTE
        end

        #second categories
        
        def emotion?
            path.include? 'EMOCJE'

        end

        def positive_emotion?
             path.include? 'POZYTYWNE_EMOCJE'
           
        end

        def negative_emotion?
            path.include? 'NEGATYWNE_EMOCJE'

        end

        def cognitive?
            path.include? 'KOGNITYWNE_PROCESY'

        end

        def sense?
            path.include? 'ZMYSLY'
        end

        def social?
            path.include? 'SOCIAL'

        end

        def bad_word?
            path.include? 'WULGAR'
        end


    
    end
end
