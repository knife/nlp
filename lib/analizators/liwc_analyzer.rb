module NLP
  class LIWCAnalyzer < Analyzer

    def initialize
      @dictionary = Dictionary.new(:liwc)
    end


    def analyze(scanner)

      results = TextStatistics.new
      results.hash = {
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
        categories = @dictionary.find(word.gsub( /[^\w-]/, "" ))
        
        unless categories.nil?
          results.add(word,categories)         
          token.category = categories.first

          results[:emotion].push token.orth if token.emotion?
          results[:social].push token.orth if token.social?
          results[:personal].push token.orth if token.personal?
          results[:wulgar].push token.orth if token.bad_word?
          results[:cognitive].push token.orth if token.cognitive?

          results[:posemotion].push token.orth if token.positive_emotion?
          results[:negemotion].push token.orth if token.negative_emotion?
        end
          #words longer than 10
          results[:long_words].push word if word.jlength > 10
          if token.zaimek?
            results[:zaimki].push word

            results[:zaimki1].push token.orth if word === 'ja' or word === 'my'
            results[:zaimki2].push token.orth if word === 'ty' or word === 'wy'
            results[:zaimki3].push token.orth if word === 'on'
          end

          results[:przyimki].push word if token.przyimek?
          results[:numbers].push token.orth if token.number? or token.liczebnik?

        results.total_words += 1
        scanner.next(:alphanum)
      end
      results

    end

  end

end	
