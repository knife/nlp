require 'rima/inflectable'
require 'rima/meaningable'

class Word < Token
	include Inflectable
	include Meaningable

        attr_reader :lemat, :orth
	
	def initialize(word, lemat, tags)
            super(word,tags)
            @lemat = lemat
	end

        def inflection
            @tags
        end

end
