# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-tradier/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-tradier"
  gem.version       = OmniAuth::Tradier::VERSION

  gem.authors       = ["Jason Barry", "Steve Agalloco"]
  gem.email         = ["jbarry@tradier.com", "sagalloco@tradier.com"]

  gem.description   = %q{OmniAuth strategy for the Tradier API}
  gem.summary       = %q{OmniAuth strategy for the Tradier API}
  gem.homepage      = "https://githubm.com/tradier/omniauth-tradier"

  gem.license       = 'MIT'

  gem.add_dependency 'omniauth-oauth2', '~> 1.1'

  gem.files         = %w(.yardopts LICENSE.md README.md Rakefile omniauth-tradier.gemspec)
  gem.files         += Dir.glob("lib/**/*.rb")
  gem.files         += Dir.glob("spec/**/*")

  gem.test_files    = Dir.glob("spec/**/*")

  gem.require_paths = ["lib"]
end
