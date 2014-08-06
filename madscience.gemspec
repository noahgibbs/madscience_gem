# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'madscience/version'

Gem::Specification.new do |spec|
  spec.name          = "madscience"
  spec.version       = MadScience::VERSION
  spec.authors       = ["Noah Gibbs"]
  spec.email         = ["noah_gibbs@yahoo.com"]
  spec.summary       = %q{Install the current version of the MadScience stack.}
  spec.description   = <<DESC
Install the current version of the MadScience stack, a group of libraries and utilities
to install your Ruby applications to a server, to allocate a server, and to test
locally on a virtual server.
DESC
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Needed to lock down versions, but not itself highly version-specific
  spec.add_runtime_dependency 'bundler', '~> 1.5'

  spec.add_runtime_dependency 'knife-solo', '0.4.2'
  spec.add_runtime_dependency 'librarian-chef', '0.0.3'
  spec.add_runtime_dependency 'chef', '11.12.8'
  spec.add_runtime_dependency 'capistrano', '3.2.1'
  spec.add_runtime_dependency 'capistrano-rails', '1.1.1'
  spec.add_runtime_dependency 'capistrano-bundler', '1.1.2'
  spec.add_runtime_dependency 'capistrano-rvm', '0.1.1'
  spec.add_runtime_dependency 'sshkit', '1.5.1'

  # Several other components of the stack like Vagrant and Chef
  # need to be used but can't be installed via RubyGems.
  # That's part of why this gem exists.

  spec.add_development_dependency 'rake'
end
