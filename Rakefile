require 'rake/testtask'
require 'rake/clean'

NAME = 'procinfo'
EXT = RbConfig::CONFIG['DLEXT']

# rule to build the extension: this says
# that the extension should be rebuilt
# after any change to the files in ext
file "lib/#{NAME}/#{NAME}.#{EXT}" =>
Dir.glob("ext/#{NAME}/*{.rb,.c}") do
  Dir.chdir("ext/#{NAME}") do
    # this does essentially the same thing
    # as what RubyGems does
    ruby "extconf.rb"
    sh "make"
  end
  mkdir_p "lib/#{NAME}"
  cp "ext/#{NAME}/#{NAME}.#{EXT}", "lib/#{NAME}"
end

# make the :test task depend on the shared
# object, so it will be built automatically
# before running the tests
task :test => "lib/#{NAME}/#{NAME}.#{EXT}"

# use 'rake clean' and 'rake clobber' to
# easily delete generated files
CLEAN.include("ext/**/*{.o,.log,.#{EXT}}")
CLEAN.include('ext/**/Makefile')
CLOBBER.include("lib/**/*.#{EXT}")

Rake::TestTask.new do |t|
  t.libs << 'spec'
  t.pattern = "spec/*_spec.rb"
end

desc "Run tests"
task :default => :test
