# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "sudoku"
  spec.version       = "1.0"
  spec.authors       = ["Praveen Rudraraju"]
  spec.summary       = %q{Short Summary}
  spec.description   = %q{Longer Description}
  spec.homepage      = "http://domain.com/"
  spec.license       = "MIT"

  spec.files         = ['lib/sudoku.rb']
  spec.executables   = ['bin/sudoku']
  spec.test_files    = ['tests/test_sudoku.rb']
  spec.require_paths = ['lib'] 
end
