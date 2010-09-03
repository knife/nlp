class String
    alias old_memeber []

    def ord (index)
        self.old_memeber index
    end

    def get(index)
        self.scan(/./)[index]
    end

    def set(index,value)
        arr = self.scan(/./)
        arr[index] = value
        self.replace(arr.join)
        value
    end
end

module RIMA
  class SearchTree
    ALPHABET = %w{* - a ą b c ć d e ę f g h i j k l ł m n ń o ó p r s ś t u w y z ź ż} 
    attr_accessor :value
    attr_accessor :subtrees
    
    # 0 -> *
    # 1 -> -
    # 2 -> a
    # 33 -> ź
    def initialize
      @subtrees = Array.new( 34, nil )
      @value = []
    end
    
    def insert( s, value )
      priv_insert( s.scan(/./), value )
    end
    
    def find( s )
      priv_find( s.scan(/./) )
    end

    
  protected
    def key( chr )
        unless chr 
            raise ArgumentError,  "Argument chr is nil"
        end
        rval = ALPHABET.index(chr) || -1  
        if rval > 35
          rval = -1 # invalid character
        end
        
       rval 
    end
    
    def priv_insert( s, value )
      if s.empty?
        @value.push value
      else
        index = key( s.first )
        subtree = if @subtrees[index] == nil
          @subtrees[index] = SearchTree.new
        else
          @subtrees[index]
        end
        
        subtree.priv_insert( s.tail, value )
      end
    end
    
    def priv_find( search )
      if @subtrees[0]
        @subtrees[0].value
      else
        if search.empty?
          value
        else
          index = key( search.first )
          if @subtrees[index]
            @subtrees[index].priv_find( search.tail )
          else
            nil
          end
        end
      end
    end

public 
   def traverse()
        list = []
        yield @value
        list.concat @subrees if @subtrees  != nil
        loop do
            break if list.empty?
            node = list.shift
            yield node.value
            list.concat node.subtrees if node.subtrees != nil
        end
end
end
end
