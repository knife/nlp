
require 'rexml/document'

module NLP
class TokenScanner
include REXML
  attr_reader :text, :tokens

    def initialize(text, method)
        @pos = 0
        
        if method === :file
            puts "laduje tekst"
            @text = load_lemated_text(text)
        elsif method === :text
            @text = lematize_text(text)
        else
            @text = text
        end

        @tokens = flatten_text(@text)
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
           
        end
    end

    def current
        
        if @pos == @tokens.size
                nil
        else
                @tokens[@pos]
        end

    end

    def index
        @pos
    end

    def end?
        @pos == tokens.size
    end
	   

    private 

    def flatten_text(text)
        flattened = []
        text.each { |s| s.tokens.each {|t| flattened.push t } }
        flattened
    end
    
   def load_lemated_text(text_file)
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

   def lematize_text(text)
        temp_text = []
       text.split(/\.|!|\?/).each do |s|
            sentence = Sentence.new
            sentence << s.split(" ").collect{ |t|
                if word = Morfeusz::Lexeme.find(t)
                   if word[0]
                        Word.new(t,word[0].base_form,"") 
                   else
                        Word.new(t,"","")
                   end
                else
                    Word.new(t,"","")
                end
            }
            temp_text.push  sentence
       end
       temp_text
   end




end

end
