# -*- encoding: utf-8 -*-
version = File.read(File.expand_path("../HYDRA_VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.name        = "hydra-head"
  s.version     = version
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Zumwalt, Bess Sadler, Julie Meloni, Naomi Dushay, Jessie Keck, John Scofield, Justin Coyne & many more.  See https://github.com/projecthydra/hydra-head/contributors"]
  s.email       = ["hydra-tech@googlegroups.com"]
  s.homepage    = "https://github.com/samvera/hydra-head"
  s.summary     = 'Hydra-Head Rails Engine'
  s.description = 'Hydra-Head is a Rails Engine containing the core code for a Hydra application.'
  s.files         = ['lib/hydra/head.rb']
  s.require_paths = ['lib']
  s.license       = 'APACHE-2.0'

  s.required_ruby_version = '>= 2.4'

  s.add_dependency 'hydra-access-controls', version
  s.add_dependency 'hydra-core', version
  s.add_dependency 'rails', '>= 5.2', '< 6.1'

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'engine_cart', '~> 2.3'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'fcrepo_wrapper', '~> 0.9'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'solr_wrapper', '~> 3.1'
  s.add_development_dependency 'rspec_junit_formatter'
end
