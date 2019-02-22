# frozen_string_literal: true

version = File.read(File.expand_path('../HYDRA_VERSION', __dir__)).strip

Gem::Specification.new do |gem|
  gem.authors     = ['Matt Zumwalt, Bess Sadler, Julie Meloni, Naomi Dushay, Jessie Keck, John Scofield, Justin Coyne & many more.  See https://github.com/projecthydra/hydra-head/contributors']
  gem.email       = ['hydra-tech@googlegroups.com']
  gem.homepage    = 'http://projecthydra.org'
  gem.summary     = 'Hydra-Head Rails Engine (requires Rails3) '
  gem.description = 'Hydra-Head is a Rails Engine containing the core code for a Hydra application. The full hydra stack includes: Blacklight, Fedora, Solr, active-fedora, solrizer, and om'

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'hydra-core'
  gem.require_paths = ['lib']
  gem.version       = version
  gem.license       = 'APACHE2'

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency 'hydra-access-controls', version
  gem.add_dependency 'railties', '>= 4.0.0', '< 6'

  gem.add_development_dependency 'rails-controller-testing', '~> 1'
  gem.add_development_dependency 'rspec-rails', '~> 3.1'
  gem.add_development_dependency 'sqlite3', '~> 1.3'
end
