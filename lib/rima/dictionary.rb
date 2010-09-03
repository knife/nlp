#
# Reggressive IMagery Analysis
#

require 'rima/stree'
require 'rima/category'

module RIMA
  class Dictionary
    
    def initialize
      @tree = SearchTree.new
      @categories = {}
      @exception_pattern = nil
    end
    
    def find( word )
      if @exception_pattern && @exception_pattern =~ word
        nil
      else
        @tree.find( word )
      end
    end
    
    def load_exceptions( exceptions_file )
      @exception_pattern = Regexp.new(
        IO.readlines( exceptions_file ).map { |line| line.chomp.downcase.gsub( /\*/, '.*' ) }.join( '|' ),
        Regexp::IGNORECASE
      )
    end

    def load_categories( category_file )
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
              category = primary = Category.new( rest )
              secondary, tertiary = nil
            elsif lead.size == 1
              category = secondary = Category.new( rest, primary )
              tertiary = nil
            elsif lead.size == 2 && ( cat = line.strip.index(/^[A-ZĄŚĘĆŃŹŻŁÓ]+$/)) && cat >= 0 
              category = tertiary = Category.new( rest, secondary )
            else
              word = rest.downcase.gsub( /\s*\(1\)$/, '' )
              @tree.insert( word, category )
            end
          rescue
            puts "Error for line: #{line}"
            raise
          end
        end
      end
    end
  end
end

