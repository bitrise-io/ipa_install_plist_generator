# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "ipa_install_plist_generator/version"

Gem::Specification.new do |s|
  s.name        = "ipa_install_plist_generator"
  s.authors     = ["Bitrise", "Viktor Benei"]
  s.email       = 'letsconnect@bitrise.io'
  s.license     = "MIT"
  # s.homepage    = "https://www.bitrise.io"
  s.version     = IpaInstallPlistGenerator::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "iOS .ipa install Plist and link generator"
  s.description = "Generate iOS .ipa (app) install Plist file and link"

  s.add_runtime_dependency 'plist', '~> 3.1', '>= 3.1.0'

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

  s.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ['ipa_plist_gen', 'ipa_install_link_gen']
  s.require_paths = ["lib"]
end
