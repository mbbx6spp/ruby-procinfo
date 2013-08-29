Gem::Specification.new do |spec|
  spec.name = 'ruby-procinfo'
  spec.version = '0.2.0'
  spec.summary = 'Retrieve process information'
  spec.description = 'Retrieve process information'
  spec.email = 'me@susanpotter.net'
  spec.homepage = 'https://github.com/mbbx6spp/ruby-procinfo'
  spec.author = 'Susan Potter'
  spec.files = Dir['lib/**/*.rb'] + Dir['lib/**/*.so'] + Dir['lib/**/*.dll'] + Dir['lib/**/*.bundle']
  spec.platform = Gem::Platform::CURRENT
  spec.require_paths = [ 'lib' ]
end
