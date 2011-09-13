require 'ds'

module NLP

  include DS

  class PlTrie < Trie

    ALPHABET = %w{- a ą b c ć d e ę f g h i j k l ł m n ń o ó p r s ś t u v w x y z ź ż} << ' '

    #private
    def priv_insert(s, value)
      if s.empty?
        if @data.nil?
          @data = [value]
        else
          @data.push value
        end
      else
        index = key(s.first)
        subtree = if @children[index]
                    @children[index]
                  else
                    @children[index] = PlTrie.new
                  end

        subtree.priv_insert(s[1..-1], value)
      end
    end
  end
end
