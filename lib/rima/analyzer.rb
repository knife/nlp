require 'rima/dictionary'
require 'morfeusz.rb'
require 'rexml/document'
require 'rima/token'
require 'rima/word'
require 'rima/emoticon'
require 'rima/sentence'
require "rima/token_scanner.rb"
require "rima/inflectable"
require "rima/meaningable"
$KODE = "UTF8"
module RIMA
  class Analyzer

    include REXML
   Lexeme = Apohllo::Morfeusz::Lexeme 
    def self.restore( state_file )
      File.open( File.expand_path( state_file ) ) do |file|
        Marshal.restore( file )
      end
    end
    
    def initialize( category_file, exceptions_file = nil )
      @dictionary = Dictionary.new
      @dictionary.load_categories( category_file )
      @dictionary.load_exceptions( exceptions_file ) unless exceptions_file.nil?
        
    end
    
    def store( state_file )
      File.open( File.expand_path( state_file ), "w" ) do |file|
        Marshal.dump( self, file )
      end
      self
    end
    
    def analyze( text )
      results = {
        :word_count => 0,
        :word_total => 0,
        :scores => Hash.new { 0 },
        :words => [] 
      }
      
      text.scan( /\w+/ ) do |word|

        #lemat = Lexeme.find(word).first.base_form  
        categories = @dictionary.find( word.gsub( /[^\w-]/, "" ) ) 
        unless categories.nil?
            puts "Mamy wiecej niz dwie kategorie!" if categories.size > 1
            categories.each do |category|
                results[:word_total] += 1
                puts "odnalazłem dla słowa #{word} kategorie: #{category.name}"
                results[:word_count] += 1
                results[:scores][category] = results[:scores][category] + 1
                results[:words].push word
            end

        end
              end
      
      results[:sorted_scores] = results[:scores].to_a.sort_by { |result| -result[1] }
      results[:classes] = {
        :primary => Float(results[:sorted_scores].select { |result| result[0].primary? }.inject( 0 ) { |count,result| count + result[1] }) / results[:word_count],
        :secondary => Float(results[:sorted_scores].select { |result| result[0].secondary? }.inject( 0 ) { |count,result| count + result[1] }) / results[:word_count],
        :emotions => Float(results[:sorted_scores].select { |result| result[0].emotions? }.inject( 0 ) { |count,result| count + result[1] }) / results[:word_count]
      }
      
      results
    end

    def analyze_takipi(text_file)
        t1 = Thread.new do 
          `takipi -i #{text_file} -o output.xml -it TXT`
        end
        t1.join

       text = []
       File.open("output.xml") do |f|
           doc = Document.new(f)

           doc.elements.each("*/chunkList/chunk") do |chunk| 
                sentence = Sentence.new
                tokens = []

                chunk.elements.each("tok") do |tok|
                   word = tok.elements[1].text
                   lemat, inflect = ""

                   tok.elements.each("lex") do |lex|
                        if lex.has_attributes?
                            lemat = lex.elements[1].text
                            inflect = lex.elements[2].text
                        end
                   end
                  
                   tokens << Word.new(word,lemat,inflect)
               end

                sentence << tokens
                text << sentence
        end
    end
    text
    end 
  end
end
