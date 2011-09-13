module NLP
  class Dictionary
    
    attr_accessor :tree

    def initialize(category_file=:rid,restore = true)
      state_file = File.expand_path(DICTIONARY_CACHE_DIR+".#{category_file.to_s}")
      if restore and File.exist?(state_file)
        @tree = Dictionary.restore(state_file) 
      else
        @tree = PlTrie.new
        load_categories(File.dirname(__FILE__)+"/../../dict/#{category_file.to_s}", category_file )
        store(state_file)
      end

    end

    def store( state_file )
      File.open( File.expand_path( state_file ), "w" ) do |file|
        Marshal.dump( self.tree, file )
      end
      self
    end

    def self.restore( state_file )
      File.open( File.expand_path( state_file ) ) do |file|
        Marshal.restore( file )
      end
    end

    def find(word)
        @tree.find(word)
    end

    def load_categories(category_file,type)
      category = nil
      primary = nil
      secondary = nil
      tertiary = nil

      if type == :rid
        cat_class = NLP.const_get("RIDCategory")
      else
        cat_class = NLP.const_get("LIWCCategory")
      end

      File.open(category_file) do |file|
        while line = file.gets
          line.chomp!
          begin
            lead, rest = line.scan(/(\t*)(.*)/).first
            if lead.size == 0
              category = primary = cat_class.new(rest)
              secondary, tertiary = nil
            elsif lead.size == 1
              category = secondary = cat_class.new(rest, primary)
              tertiary = nil
            elsif lead.size == 2 && ( cat = line.strip.index(/^[A-ZĄŚĘĆŃŹŻŁÓ_]+$/)) && cat >= 0 
              category = tertiary = cat_class.new( rest, secondary )
            else
              word = rest.downcase.gsub( /\s*\(1\)$/, '' )
              @tree.insert(word, category)
            end
          rescue
            raise
          end
        end
      end
    end
  end
end

