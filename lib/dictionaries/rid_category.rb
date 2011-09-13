module NLP
  class RIDCategory < Category

    def self.top_level
      [new(:PIERWOTNE),new(:WTORNE),new(:EMOCJE)]
    end

    def primary?
      root == :PIERWOTNE
    end

    def secondary?
      root == :WTORNE
    end

    def emotions?
      root == :EMOCJE
    end

  end
end
