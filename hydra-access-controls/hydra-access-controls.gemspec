# -*- encoding: utf-8 -*-
version = File.read(File.expand_path("../../HYDRA_VERSION", __FILE__)).strip

Gem::Specification.new do |gem_spec|
  gem_spec.authors       = ["Chris Beer", "Justin Coyne", "Matt Zumwalt"]
  gem_spec.email         = ["samvera-tech@googlegroups.com"]
  gem_spec.description   = %q{Access controls for the Samvera Community}
  gem_spec.summary       = %q{Access controls for the Samvera Community}
  gem_spec.homepage      = "https://github.com/samvera/hydra-head/tree/master/hydra-access-controls"

  gem_spec.files         = `git ls-files`.split($\)
  gem_spec.executables   = gem_spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem_spec.test_files    = gem_spec.files.grep(%r{^(test|spec|features)/})
  gem_spec.name          = "hydra-access-controls"
  gem_spec.require_paths = ["lib"]
  gem_spec.version       = version
  gem_spec.license       = "APACHE-2.0"

  gem_spec.required_ruby_version = '>= 2.4'

  gem_spec.add_dependency 'activesupport', '< 7'
  gem_spec.add_dependency 'blacklight-access_controls'
  gem_spec.add_dependency 'cancancan'
  gem_spec.add_dependency 'deprecation'

  gem_spec.add_development_dependency 'rake'
  gem_spec.add_development_dependency 'rspec'
end
