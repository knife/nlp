require 'takipi_web_service'
require 'rexml/document'
require 'morfeusz'

module NLP
class Lemmatizer
    include REXML
    
    def self.lematize(text,method,input_type)
        if text.is_a? File
            str = text.read
            text.close
        elsif text.is_a? String
           str = text
        else
            raise ArgumentError, "Argument is not String or File"
        end

        if method === :takipi
            takipi_lematize(str,input_type)
        #Default lematization method is  Morfeusz 
        else 
            morfeusz_lematize(str)
        end

    end



    def self.takipi_lematize(text,method)
        
        if method === :local

            t1 = Thread.new do 
                 `takipi -i text.txt -o output.xml -it TXT`
            end

            t1.join

            f = File.open("output.xml","r")
            doc = Document.new f
        elsif method === :remote
            xml = TakipiWebService.request(text)
            doc = Document.new xml
        else
            raise ArgumentError, 'Argument is not :local or :remote'
        end

        parse_lematized_xml(doc)    
    end 


    def self.morfeusz_lematize(text)
            temp_text = []
            
            #simple tagger
            #TODO lematizer should take block or object Tagger that defines
            #how split string
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


    def self.parse_lematized_xml(doc)
        
        text = Text.new

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
        text
    end


end
end
