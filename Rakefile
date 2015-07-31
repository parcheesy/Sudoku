lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rake/testtask'
require 'rename'

#Set rake test task to run all tests
Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/test*.rb']
  t.verbose = true
end

#Tasks related to creating and maintaining projects
namespace :project do
  
  desc "create new project from skeleton"
  task :make do
    
    ARGV.each { |a| task a.to_sym do ; end }

    FileUtils.gsub 'NAME.gemspec', 'NAME', ARGV[1]
    FileUtils.mv 'NAME.gemspec', "#{ARGV[1]}.gemspec"

    FileUtils.mv 'bin/NAME', "bin/#{ARGV[1]}"

    FileUtils.gsub 'tests/test_NAME.rb', 'NAME', ARGV[1]
    FileUtils.mv 'tests/test_NAME.rb', "tests/test_#{ARGV[1]}.rb"

    FileUtils.mv 'lib/NAME', "lib/#{ARGV[1]}"
    FileUtils.mv 'lib/NAME.rb', "lib/#{ARGV[1]}.rb"


    

  end



end
