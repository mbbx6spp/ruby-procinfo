Gem::Specification.new do |spec|
  spec.name = 'ruby-procinfo'
  spec.version = '0.2.1'
  spec.summary = 'Retrieve process and uname information.'
  spec.description =
    'Retrieve process information for self, children and retrieve uname via Ruby/C native extension with minimal overhead.'
  spec.email = 'me@susanpotter.net'
  spec.homepage = 'https://github.com/mbbx6spp/ruby-procinfo'
  spec.author = 'Susan Potter'
  spec.license = 'BSD-3-Clause'
  spec.files =
    Dir['lib/**/*.rb'] +
      Dir['lib/**/*.so'] +
      Dir['lib/**/*.dll'] +
      Dir['lib/**/*.bundle']
  spec.platform = Gem::Platform::CURRENT
  spec.require_paths = [ 'lib' ]
end
