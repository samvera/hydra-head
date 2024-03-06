# -*- encoding: utf-8 -*-
version = File.read(File.expand_path("../../HYDRA_VERSION", __FILE__)).strip

Gem::Specification.new do |gem|
  gem.authors       = ["Chris Beer", "Justin Coyne", "Matt Zumwalt"]
  gem.email         = ["hydra-tech@googlegroups.com"]
  gem.description   = %q{Access controls for project hydra}
  gem.summary       = %q{Access controls for project hydra}
  gem.homepage      = "https://github.com/samvera/hydra-head/tree/master/hydra-access-controls"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hydra-access-controls"
  gem.require_paths = ["lib"]
  gem.version       = version
  gem.license       = "APACHE-2.0"
  gem.metadata      = { "rubygems_mfa_required" => "true" }

  gem.required_ruby_version = '>= 2.4'

  gem.add_dependency 'activesupport', '>= 5.2', '< 7.2'
  gem.add_dependency 'active-fedora', '>= 10.0.0'
  gem.add_dependency 'blacklight-access_controls', '~> 6.0'
  gem.add_dependency 'cancancan', '>= 1.8', '< 4'
  gem.add_dependency 'deprecation', '~> 1.0'

  gem.add_development_dependency 'rake', '>= 12.3.3'
  gem.add_development_dependency 'rspec', '~> 4.0'
end
