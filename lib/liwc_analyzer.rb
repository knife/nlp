module NLP
class LIWCAnalyzer < Analyzer
   
    def initialize( category_file, restore = true )
        state_file = File.expand_path(Analyzer::CACHE_DIR+'.liwc')
        if restore 
           @dictionary = Dictionary.restore(state_file) 
        else
            @dictionary = Dictionary.new
            @dictionary.load_categories( category_file, :rid => false )
            @dictionary.store(state_file)
        end
        
    end


	
        def analyze(scanner)

	    results = {
                :word_count => 0,
                :word_total => 0,
                :scores => Hash.new { 0 },
                :words => [],
                :cwords => Hash.new { nil },
                :long_words => [],
                :zaimki => [],
		:zaimki1 => [],
		:zaimki2 => [],
		:zaimki3 => [],
                :przyimki => [],
                :numbers => [],
                :emotion => [],
                :social => [],
                :personal => [],
                :posemotion => [],
                :negemotion => [],
                :wulgar => [],
                :cognitive => []

              }

             while token = scanner.current
                word = token.lemat

                categories = @dictionary.find( word.gsub( /[^\w-]/, "" ) ) 
                unless categories.nil?
                    categories.each do |category|
                       puts "Znalazłem słowo #{word} : #{category} root: #{category.root}"
                       token.category = category
                        results[:scores][category] = results[:scores][category] + 1

                        
                        if results[:cwords][category.name].nil?
                            results[:cwords][category.name] = []
                        end
                        results[:cwords][category.name].push token.orth

                        
                        results[:emotion].push token.orth if token.emotion?
                        results[:social].push token.orth if token.social?
                        results[:personal].push token.orth if token.personal?
                        results[:wulgar].push token.orth if token.bad_word?
                        results[:cognitive].push token.orth if token.cognitive?
                        
                        results[:posemotion].push token.orth if token.positive_emotion?
                        results[:negemotion].push token.orth if token.negative_emotion?
                        results[:word_count] += 1
                        results[:words].push word
                    end
                end

                #words longer than 9
                results[:long_words].push word if word.jlength > 9
		if token.zaimek?
                	results[:zaimki].push word

			results[:zaimki1].push token.orth if word === 'ja' or word === 'my'
			results[:zaimki2].push token.orth if word === 'ty' or word === 'wy'
			results[:zaimki3].push token.orth if word === 'on'
		end
		
                results[:przyimki].push word if token.przyimek?
                results[:numbers].push token.orth if token.number? or token.liczebnik?


                results[:word_total] += 1
                scanner.next(:alphanum)
             end
             results
	
	end


end

end	
