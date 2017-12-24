# coding: utf-8
Gem::Specification.new do |s|
  s.name        = 'arango-client'
  s.version     = '0.0.2'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Don Kelly"]
  s.email       = ["karfai@gmail.com"]
  s.summary     = "Simple ArangoDB client"
  s.description = ""

  s.add_dependency 'activesupport'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'fuubar'

  s.files        = Dir.glob("{bin,lib}/**/*")
  s.require_path = 'lib'
end
