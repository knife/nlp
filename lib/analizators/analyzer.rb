module NLP

  class Analyzer

    def initialize(dict)
      @dictionary = Dictionary.new(dict)
    end


    def analyze(scanner)

      results = TextStatistics.new

      while token = scanner.current
        word = token.lemat

        categories = @dictionary.find(word) 
        results.add(word,categories) unless categories.nil?
        results.total_words += 1
        scanner.next(:word)
      end

      results

    end
  end
end

