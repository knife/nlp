require 'dictionary'
#require 'morfeusz'
require 'token'
require 'word'
require 'emoticon'
require 'sentence'
require "token_scanner.rb"
require "lemmatizer"

$KODE = "UTF8"

module NLP

  class Analyzer

   # include REXML
    
    def initialize( category_file, restore = true )
        state_file = File.expand_path(Dictionary::CACHE_DIR)
        if restore 
           @dictionary = Dictionary.restore(state_file) 
        else
            @dictionary = Dictionary.new
            @dictionary.load_categories( category_file )
            @dictionary.store(state_file)
        end
        
    end
    
    
    def analyze( scanner)
      
     results = {
        :word_count => 0,
        :word_total => 0,
        :scores => Hash.new { 0 },
        :words => [] 
      }

     while token = scanner.current
        word = token.lemat

        categories = @dictionary.find( word.gsub( /[^\w-]/, "" ) ) 
        unless categories.nil?
            categories.each do |category|
                
                results[:scores][category] = results[:scores][category] + 1
            end
            
            results[:word_count] += 1
            results[:words].push word
        end

        results[:word_total] += 1
        scanner.next(:word)
     end
      
      results[:sorted_scores] = results[:scores].to_a.sort_by { |result| -result[1] }
      results[:classes] = {
        :primary => Float(results[:sorted_scores].select { |result| result[0].primary? }.inject( 0 ) { |count,result| count + result[1] }) / results[:word_count],
        :secondary => Float(results[:sorted_scores].select { |result| result[0].secondary? }.inject( 0 ) { |count,result| count + result[1] }) / results[:word_count],
        :emotions => Float(results[:sorted_scores].select { |result| result[0].emotions? }.inject( 0 ) { |count,result| count + result[1] }) / results[:word_count]
      }
      
      results
    end

  end
end
