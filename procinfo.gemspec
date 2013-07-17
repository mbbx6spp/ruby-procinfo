Gem::Specification.new do |s|
  s.name = 'procinfo'
  s.version = '0.1.0'
  s.authors = ['Susan Potter']
  s.summary = 'Provide cross *NIX OS uniform interface to process info'
  s.files = Dir.glob('lib/**/*.rb') +
    Dir.glob("ext/**/*.{c,h,rb}")
  s.extensions = ['ext/procinfo/extconf.rb']
  s.executables = ['procinfo']

end
