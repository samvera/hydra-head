# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hydra-head/version"

Gem::Specification.new do |s|
  s.name        = "hydra-head"
  s.version     = Hydra::Head::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Zumwalt"]
  s.email       = ["hydra-tech@groups.google.com","collaborate@yourmediashelf.com"]
  s.homepage    = "http://projecthydra.org"
  s.summary     = %q{A rails engine that gives you the basic functionality for creating a Hydra Head}
  s.description = %q{The hydra-head rails engine gives you the basic functionality for creating a Hydra Head. Hydra Heads allow you to Create, Annotate, Arrange, and Disseminate digital content of any type.}

  s.rubyforge_project = "hydra-head"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "rails", ">= 3.0.5"
  
end
