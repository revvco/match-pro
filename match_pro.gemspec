
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "match_pro/version"

Gem::Specification.new do |spec|
  spec.name          = "match_pro"
  spec.version       = MatchPro::VERSION
  spec.authors       = ["Sikandar Shukla"]
  spec.email         = ["sik@revv.co"]

  spec.summary       = "RubyGem for the 360MatchPro Partners."
  spec.homepage      = "https://github.com/revvco/match-pro"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_runtime_dependency("rest-client", '< 4.0', '>= 1.6.7')
  spec.add_runtime_dependency("json", '>= 2.3.0')
  spec.add_runtime_dependency('mime-types', '< 4.0', '>= 1.25.1')
  spec.add_runtime_dependency('hashie', '< 4.0', '>= 1.2.0')

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
