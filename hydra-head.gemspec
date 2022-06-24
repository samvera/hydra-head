# -*- encoding: utf-8 -*-
version = File.read(File.expand_path("../HYDRA_VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.name        = "hydra-head"
  s.version     = version
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Zumwalt", "Bess Sadler", "Julie Meloni", "Naomi Dushay", "Jessie Keck", "John Scofield", "Justin Coyne", "https://github.com/samvera/hydra-head/contributors"]
  s.email       = ["samvera-tech@googlegroups.com"]
  s.homepage    = "https://github.com/samvera/hydra-head"
  s.summary     = 'Hydra-Head Rails Engine'
  s.description = %q{Hydra-Head is a Rails Engine containing the core code for a Samvera application}
  s.files         = ['lib/hydra/head.rb']
  s.require_paths = ['lib']
  s.license       = 'APACHE-2.0'

  s.required_ruby_version = '>= 2.4'

  s.add_dependency 'hydra-access-controls', version
  s.add_dependency 'hydra-core', version
  s.add_dependency 'rails', '>= 5.2', '< 7'

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'engine_cart'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec_junit_formatter'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'simplecov'
end
