require "./lib/sudoku"
require "test/unit"

class TestCheck < Test::Unit::TestCase

  def test_sudoku_check
    make = Sudoku.make(44) 
    p = make[0]
    s = make[1]
    check = Sudoku.check(p, s)
    assert_equal p[0]==s[0], check[0]
    assert_equal 81, check.length
  end

end

