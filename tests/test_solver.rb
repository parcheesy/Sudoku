require "./lib/sudoku"
require "test/unit"

class TestSolver < Test::Unit::TestCase

  def test_solver_initialize_creator
   c = Sudoku::Creator.new
   c.create_base
   s = Sudoku::Solver.new(c)
   assert_equal c.puzzle, s.puzzle
  end

  def test_solver_initialize_array
    ar = ["."] * 81
    s = Sudoku::Solver.new(ar)
    assert s
  end

  def test_solver_initialize_str
    str = "." * 81
    s = Sudoku::Solver.new(str)
    assert s
  end

  def test_check_options
    c = Sudoku::Creator.new
    c.create_base
    s = Sudoku::Solver.new(c)
    index = 10
    assert s.check_options(index).empty?
  end

  def test_each_unknown
    c = Sudoku::Creator.new
    c.create_base
    s = Sudoku::Solver.new(c)
    index = 10
    s[index] = "."
    unknown_index = nil
    s.each_unknown {|i| unknown_index = i }
    assert_equal index, unknown_index

  end

end
