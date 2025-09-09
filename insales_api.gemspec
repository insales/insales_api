# frozen_string_literal: true

# $LOAD_PATH.push File.expand_path('lib', __dir__)
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'insales_api/version'

Gem::Specification.new do |s|
  s.name        = 'insales_api'
  s.version     = InsalesApi::VERSION::STRING
  s.authors     = 'InSales'
  s.email       = 'dg@insales.ru'
  s.homepage    = 'https://github.com/insales/insales_api'
  s.summary     = 'Gem for accessing the InSales REST web services'
  s.description = 'Gem for accessing the InSales REST web services'

  if s.respond_to?(:metadata) # old rubygems do not support metadata
    s.metadata["homepage_uri"] = s.homepage
    s.metadata["source_code_uri"] = "https://github.com/insales/insales_api"
    s.metadata["changelog_uri"] = "https://github.com/insales/insales_api/blob/master/CHANGELOG.md"
  end

  s.required_ruby_version = '>= 2.3'

  s.files = `git ls-files`.split("\n").reject do |f|
    f.match(Regexp.union(
              %r{^gemfiles/},
              %r{^spec/},
              /^\./,
              /^Appraisals/,
              /^Gemfile/,
              /^Rakefile/
            ))
  end

  s.add_dependency('activesupport', ['>= 3.0.0'])
  s.add_dependency('activeresource', ['>= 6.0.0'])

  s.add_development_dependency 'rake', '>= 10.3'
  s.add_development_dependency 'rspec', '~> 3.12'
end
