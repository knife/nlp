require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "nlp"
    gem.summary = %Q{Linguistics tools for processing polish language.}
    gem.description = %Q{Tools for processing polish language. Tokenization, scanning, categorization...}
    gem.email = "satre@o2.pl"
    gem.homepage = "http://github.com/knife/nlp"
    gem.authors = ["knife"]
    gem.files = Dir["lib/*"] + Dir["lib/stdlib/ext/*"] + Dir["dict/*"]+Dir["lib/tagger/*"] +  Dir["lib/dictionaries/*"]+ Dir["lib/analizators/*"]

    gem.add_dependency 'savon', '= 0.7.9'
    gem.add_dependency 'ds'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "nlp #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
