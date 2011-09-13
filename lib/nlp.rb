module  NLP
   TAKIPI_XML_FILE = "/tmp/output.xml"
   DICTIONARY_CACHE_DIR = "~/"
end


require 'stdlib/ext/array'
require 'morfeusz'

require "analizators/analyzer"
require "analizators/rid_analyzer.rb"
require "analizators/liwc_analyzer.rb"

require "dictionaries/pl_trie"
require 'dictionaries/dictionary'
require 'dictionaries/category'
require "dictionaries/liwc_category"
require "dictionaries/rid_category"


require "tagger/inflectable"
require "tagger/meaningable"
require 'tagger/token'
require 'tagger/word'
require 'tagger/emoticon'
require 'tagger/sentence'
require 'tagger/text'
require "tagger/token_scanner"
require "tagger/takipi_web_service"
require "tagger/lemmatizer"

require "text_statistics"

require 'jcode'
$KCODE = "UTF8"

