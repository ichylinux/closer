lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'closer/version'

Gem::Specification.new do |spec|
  spec.name          = "closer"
  spec.version       = Closer::VERSION
  spec.authors       = ["ichy"]
  spec.email         = ["ichylinux@gmail.com"]
  spec.summary       = %q{Cucumber test execution tool}
  spec.description   = %q{You can run cucumber test easily.}
  spec.homepage      = "https://github.com/ichylinux/closer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.1'

  spec.add_runtime_dependency 'cucumber', '~> 2.3'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 11.0"
end
