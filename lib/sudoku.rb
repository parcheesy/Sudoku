lib = File.expand_path('../sudoku', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


require "errors"
require "puzzle"
require "creator"
require "solver"
require "scan"
require "make"
require "check"
