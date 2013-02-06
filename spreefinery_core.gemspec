# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "spreefinery_core"
  gem.version       = "0.0.1"
  gem.authors       = ["Alexander Negoda, Zee Yang"]
  gem.email         = ["alexander.negoda@gmail.com, zee.yang@gmail.com"]
  gem.description   = "Common for Spree + Refinerycms integration"
  gem.summary       = "Common for Spree + Refinerycms integration"
  gem.homepage      = "https://github.com/shoponrails/spreefinery_core"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'spree', '>= 1.3.0'
  gem.add_runtime_dependency 'refinerycms', '>= 2.0.9'
end
