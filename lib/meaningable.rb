module Meaningable

  #LIWC
  #primary categories

  def linguistic?
    category.root == :PIERWOTNE
  end

  def psychological?
    category.root == :PROCESY_PSYCHOLOGICZNE
  end


  def relative?
    category.root === :RELATYWNOSC
  end

  def personal?
    category.root == :OSOBISTE
  end

  #second categories

  def emotion?
    category.path.include? 'EMOCJE'

  end

  def positive_emotion?
    category.path.include? 'POZYTYWNE_EMOCJE'

  end

  def negative_emotion?
    category.path.include? 'NEGATYWNE_EMOCJE'

  end

  def cognitive?
    category.path.include? 'KOGNITYWNE_PROCESY'

  end

  def sense?
    category.path.include? 'ZMYSLY'
  end

  def social?
    category.path.include? 'SOCIAL'

  end

  def bad_word?
    category.path.include? 'WULGAR'
  end


  #SEMANTIC
  def synonym?(other)

  end

  def synonyms

  end


end
