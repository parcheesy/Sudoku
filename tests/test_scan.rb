require "./lib/sudoku"
require "test/unit"

class TestScan < Test::Unit::TestCase

  def test_sudoku_scan_solved
    c = Sudoku::Creator.new
    c.create_base
    c.randomize_base
    s = Sudoku::Solver.new(c)
    s[3] = "."
    s[79] = "."
    min_index, min_set = Sudoku.scan(s)
    assert min_index == nil && min_set == nil
  end

  def test_sudoku_scan_unsolved
    c = Sudoku::Creator.new
    c.create_base
    s = Sudoku::Solver.new(c)
    0.upto(17) do |index|
      s[index] = "."
    end
    min_index, min_set = Sudoku.scan(s)
    assert min_index != nil && min_set != nil
  end

  def test_sudoku_solve_works
    c = Sudoku::Creator.new
    c.create_base
    c.randomize_base
    s = Sudoku::Solver.new(c)
    s[3] = "."
    assert Sudoku.solve(s)
  end

  def test_sudoku_solve_impossible_error
    c = Sudoku::Creator.new
    c.create_base
    s = Sudoku::Solver.new(c)
    val = s[0]
    s[9] = val
    s[0] = "."
    assert_raise(Sudoku::Impossible) { Sudoku.solve(s) }
  end

  def test_sudoku_solve_multiplesolution_error
    x = '.8...9743.5...8.1..1.......8....5......8.4......3....6.......7..3.5...8.9724...5.'
    s = Sudoku::Solver.new(x)
    assert_raise(Sudoku::MultipleSolutions) { Sudoku.solve(s) }
  end


end

