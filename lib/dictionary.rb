
require 'stree'
require 'category'
require 'rid_category'
require 'liwc_category'

module NLP
  class Dictionary
    def initialize
      @tree = SearchTree.new
      @categories = {}
    end
        
    def store( state_file )
      File.open( File.expand_path( state_file ), "w" ) do |file|
        Marshal.dump( self, file )
      end
      self
    end

    def self.restore( state_file )
      File.open( File.expand_path( state_file ) ) do |file|
        Marshal.restore( file )
      end
    end


    
    def find( word )
      if @exception_pattern && @exception_pattern =~ word
        nil
      else
        @tree.find( word )
      end
    end
    

    def load_categories( category_file,options )
      category = nil
      primary = nil
      secondary = nil
      tertiary = nil
    
      File.open( category_file ) do |file|
        while line = file.gets
          line.chomp!
          begin
            lead, rest = line.scan( /(\t*)(.*)/ ).first
            if lead.size == 0
		    if options[:rid]
              category = primary = RIDCategory.new( rest )
		    else
              category = primary = LIWCCategory.new( rest )
		    end

              secondary, tertiary = nil
            elsif lead.size == 1
		    if options[:rid]
              category = secondary = RIDCategory.new( rest, primary )
		    else
			    category = secondary = LIWCCategory.new(rest,primary)
		    end
              tertiary = nil
            elsif lead.size == 2 && ( cat = line.strip.index(/^[A-ZĄŚĘĆŃŹŻŁÓ_]+$/)) && cat >= 0 
		    if options[:rid]

              category = tertiary = RIDCategory.new( rest, secondary )
		    else
              category = tertiary = LIWCCategory.new( rest, secondary )
		    end
            else
              word = rest.downcase.gsub( /\s*\(1\)$/, '' )
              @tree.insert( word, category )
            end
          rescue
            raise
          end
        end
      end
    end
  end
end

