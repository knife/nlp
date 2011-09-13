module NLP
  class TextStatistics

    attr_accessor :total_words, :hash
    attr_reader :cwords, :words, :total_words, :word_count, :scores

    def initialize
      @word_count = 0           # number of found words
      @total_words = 0          # total number of words
      @scores = Hash.new { 0 }  #numbers of words in each category
      @words = []               #found words
      @cwords = Hash.new {nil}  #found words grouped into categories   
      @hash = {}                #additional data
    end

    #Adds word and its category to stats.    
    def add(word,categories)
      categories.each do |category|
        @cwords[category] = [] if @cwords[category].nil?
        @cwords[category].push word
        @scores[category] += 1
      end
      @words.push word
      @word_count += 1
    end

    def [](key)
        @hash[key]
    end

    def []=(key,value)
      @hash[key] = value
    end

    def category_participation(categories)
      sorted_scores = @scores.to_a.sort_by{ |result| -result[1] }
      r = {}
      categories.each do |cat|
        r[cat] = percentage_distribution(sorted_scores){|c| c.send(cat.to_s+'?')}
      end
      r
    end

    private
    def percentage_distribution scores, &block
      all = scores.map{|k,v| v}.inject(0){|e,m|m = m +e}
      sum = scores.select{|result| yield result[0]}.inject(0){|count,result| count + result[1]}
      Float(sum)/all
    end

  end
end

