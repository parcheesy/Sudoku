require "./lib/sudoku"
require "test/unit"

class TestMaker < Test::Unit::TestCase

  def test_sudoku_make
    p = Sudoku.make(40)[0]
    count = 0
    p.puzzle.each do |entry|
      count += 1 if entry=="."
    end
    assert_equal 40, count
  end


end
