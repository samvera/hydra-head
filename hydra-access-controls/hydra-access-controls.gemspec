# -*- encoding: utf-8 -*-
version = File.read(File.expand_path("../../HYDRA_VERSION", __FILE__)).strip

Gem::Specification.new do |gem|
  gem.authors       = ["Chris Beer", "Justin Coyne", "Matt Zumwalt"]
  gem.email         = ["samvera-tech@googlegroups.com"]
  gem.description   = %q{Access controls for the Samvera Community}
  gem.summary       = %q{Access controls for the Samvera Community}
  gem.homepage      = "https://github.com/samvera/hydra-head/tree/master/hydra-access-controls"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hydra-access-controls"
  gem.require_paths = ["lib"]
  gem.version       = version
  gem.license       = "APACHE-2.0"

  gem.required_ruby_version = '>= 2.4'

  gem.add_dependency 'activesupport', '< 7'
  gem.add_dependency 'blacklight-access_controls'
  gem.add_dependency 'cancancan'
  gem.add_dependency 'deprecation'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
