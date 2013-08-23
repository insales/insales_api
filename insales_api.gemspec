# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "insales_api/version"

Gem::Specification.new do |s|
  s.name        = "insales_api"
  s.version     = InsalesApi::VERSION
  s.authors     = "InSales"
  s.email       = "dg@insales.ru"
  s.homepage    = "http://wiki.insales.ru/wiki/%D0%9A%D0%B0%D0%BA_%D0%B8%D0%BD%D1%82%D0%B5%D0%B3%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D1%82%D1%8C%D1%81%D1%8F_%D1%81_InSales"
  s.summary     = %q{Gem for accessing the InSales REST web services}
  s.description = %q{Gem for accessing the InSales REST web services}

  s.rubyforge_project = "insales_api"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_dependency("activesupport", [">= 3.0.0"])
  s.add_dependency("activeresource", [">= 3.0.0"])
  s.add_development_dependency "rspec"
end
