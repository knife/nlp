require 'dictionary'
#require 'morfeusz'
require 'token'
require 'word'
require 'token'
require 'text'
require 'emoticon'
require 'sentence'
require "token_scanner.rb"
require "lemmatizer"
require 'jcode'
require 'statistic'
$KODE = "UTF8"

module NLP

  class Analyzer

    def initialize(dict)
      @dictionary = Dictionary.new(dict)
    end


    def analyze(scanner)

      results = Statistic.new

      while token = scanner.current
        word = token.lemat

        categories = @dictionary.find(word.gsub(/[^\w-]/, "" )) 
        unless categories.nil?
          categories.each do |category|
            puts "Znalazłem słowo #{word} : #{category}"
            results.add(word,category)
          end
        end

        results.total_words += 1
        scanner.next(:word)
      end

      results

    end
  end
end

require "rid_analyzer.rb"
require "liwc_analyzer.rb"
