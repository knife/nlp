module NLP
  class RIDCategory < Category

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
