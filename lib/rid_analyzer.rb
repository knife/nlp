module NLP
    class  RIDAnalyzer < NLP::Analyzer

	    
	def initialize( category_file, restore = true )
        state_file = File.expand_path(Analyzer::CACHE_DIR+'.rid')
        if restore 
           @dictionary = Dictionary.restore(state_file) 
        else
            @dictionary = Dictionary.new
            @dictionary.load_categories( category_file, :rid => true )
            @dictionary.store(state_file)
        end
        
    end


        def analyze(scanner)
             results = {
                :word_count => 0,
                :word_total => 0,
                :scores => Hash.new { 0 },
                :words => [],
                :cwords => Hash.new { nil } 
              }

             while token = scanner.current
                word = token.lemat

                categories = @dictionary.find( word.gsub( /[^\w-]/, "" ) ) 
                unless categories.nil?
                    categories.each do |category|
                       puts "Znalazłem słowo #{word} : #{category} root: #{category.root}"
                        results[:scores][category] = results[:scores][category] + 1
                        category = category.name
                        if results[:cwords][category].nil?
                            results[:cwords][category] = []
                        end
                        results[:cwords][category].push word
                        results[:word_count] += 1
                        results[:words].push word
                    end
                    
                    
                end

                results[:word_total] += 1
                scanner.next(:word)
             end
              
              results[:sorted_scores] = results[:scores].to_a.sort_by { |result| -result[1] }
                p primary_sum = results[:sorted_scores].select { |result| result[0].primary? }.inject( 0 ) { |count,result| count + result[1] }
                p secondary_sum = results[:sorted_scores].select { |result| result[0].secondary? }.inject( 0 ) { |count,result| count + result[1] }
                p emotion_sum = results[:sorted_scores].select { |result| result[0].emotions? }.inject( 0 ) { |count,result| count + result[1] }
                


              results[:classes] = {
                :primary => Float(primary_sum) / results[:word_count],
                :secondary => Float(secondary_sum) / results[:word_count],
                :emotions => Float(emotion_sum) / results[:word_count]
              }
              
              results
        end





    end
	
	
end
