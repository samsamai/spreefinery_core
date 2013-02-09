# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "spreefinery_core"
  gem.version       = "0.0.2"
  gem.authors       = ["Alexander Negoda, Zee Yang"]
  gem.email         = ["alexander.negoda@gmail.com, zee.yang@gmail.com"]
  gem.description   = "Spree + Refinerycms integration"
  gem.summary       = "Common functionality for Spree + Refinerycms integration"
  gem.homepage      = "https://github.com/shoponrails/spreefinery_core"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]
  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency 'liquid', '>= 2.4.1'
  gem.add_dependency 'clot_engine', '>= 1.2'

  gem.add_dependency 'spree', '>= 1.3.2'
  gem.add_dependency 'refinerycms', '>= 2.0.9'
  gem.add_dependency 'refinerycms-i18n'
  gem.add_dependency 'refinerycms-settings'
  gem.add_dependency 'spreefinery_themes'
end
