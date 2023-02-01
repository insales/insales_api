# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'insales_api/version'

Gem::Specification.new do |s|
  s.name        = 'insales_api'
  s.version     = InsalesApi::VERSION::STRING
  s.authors     = 'InSales'
  s.email       = 'dg@insales.ru'
  s.homepage    = 'https://github.com/insales/insales_api'
  s.summary     = 'Gem for accessing the InSales REST web services'
  s.description = 'Gem for accessing the InSales REST web services'

  s.rubyforge_project = 'insales_api'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  s.add_dependency('activeresource', ['>= 3.0.0'])
  s.add_dependency('activesupport', ['>= 3.0.0'])
  s.add_development_dependency 'rake', '~> 10.3'
  s.add_development_dependency 'rspec', '~> 3.12'
end
