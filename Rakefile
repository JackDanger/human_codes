begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "human_codes"
    gem.summary = %Q{Convert integers to human-readable compressed alphanumeric strings and back. Lets humans enter very long integers quickly.}
    gem.description = %Q{Convert integers to human-readable compressed alphanumeric strings and back. Lets humans enter very long integers quickly. Uses base-32 compression of integers.}
    gem.email = "rubygems@6brand.com"
    gem.homepage = "http://github.com/JackDanger/human_codes"
    gem.authors = ["Jack Danger Canty"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end



task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << '.'
  test.pattern = 'test/test_*.rb'
  test.verbose = true
end
