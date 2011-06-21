class Statistic

  attr_accessor :total_words, :hash
  attr_reader :cwords, :words, :total_words, :word_count
  
  def initialize
    @word_count = 0
    @total_words = 0
    @scores = Hash.new { 0 }
    @words = []
    @cwords = Hash.new {nil}
    @hash
  end

  def add(word,category)

    @scores[category] += 1
    @word_count += 1
    @words.push word

    category = category.name
    if @cwords[category].nil?
      @cwords[category] = []
    end
    @cwords[category].push word

  end

  def []=(key,value)
    @hash[key] = value 
  end

  def [](key)
    @hash[key]
  end

  def category_participation(categories)
    sorted_scores = @scores.to_a.sort_by { |result| -result[1] }
    r = {}
    categories.each do |cat|
      r[cat] = percentage_distribution(sorted_scores){|c| c.send(cat.to_s+'?')}
    end
    r
  end

  private
  
  def percentage_distribution scores, &block
    sum = scores.select{|result| yield result[0]}.inject(0){|count,result| count + result[1]}
    Float(sum)/@word_count 
  end

end


