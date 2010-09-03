class String
    alias old_memeber []

    def ord (index)
        self.old_memeber index
    end

    def [](index)
        self.scan(/./)[index]
    end

    def []=(index,value)
        arr = self.scan(/./)
        arr[index] = value
        self.replace(arr.join)
        value
    end
end

module RIMA
  class SearchTree
    OFFSET = 'a'[0].freeze
    
    attr_accessor :value
    
    # 0 -> *
    # 1 -> -
    # 2 -> a
    # 33 -> ź
    def initialize
      @subtrees = Array.new( 33, nil )
      @value = nil
    end
    
    def insert( s, value )
      priv_insert( s.scan(/./), value )
    end
    
    def find( s )
      priv_find( s.scan(/./) )
    end
    
  protected
    def key( chr )
      if chr == '*'
        0
      elsif chr == '-'
        1
      else
          p chr.downcase.ord(0)
        rval = chr.downcase.ord(0) - OFFSET + 2
        
        if rval < 2 || rval > 34
          rval = -1 # invalid character
        end
        
        rval
        
      end
    end
    
    def priv_insert( s, value )
      if s.empty?
        @value = value
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
  end
end
