require "./lib/sudoku"
require "test/unit"

class TestPuzzle < Test::Unit::TestCase

  def test_initialize
    p = Sudoku::Puzzle.new
    assert_equal p.puzzle.size, 81
  end

  def test_calculate_row
    p = Sudoku::Puzzle.new
    assert_equal 4, p.calculate_row(36)
  end

  def test_calculate_column
    p = Sudoku::Puzzle.new
    assert_equal 0, p.calculate_column(36)
  end

  def test_calculate_box
    p = Sudoku::Puzzle.new
    assert_equal 3, p.calculate_box(36)
  end

  def test_array_access_operator
    p = Sudoku::Puzzle.new
    index = 10
    p.puzzle[index] = "5"
    assert_equal p.puzzle[index], p[index]
  end

  def test_array_access_assign
    p = Sudoku::Puzzle.new
    index = 10
    value = "3"
    p[index] = value
    assert_equal value, p.puzzle[index]
  end

  def test_add_value
    p = Sudoku::Puzzle.new
    index = 23
    value = "4"
    p.add_value(index, value)
    assert p.rows[p.calculate_row(index)].include? value
  end

  def test_subtract_value
    p = Sudoku::Puzzle.new
    index = 23
    value = "4"
    p.add_value(index, value)
    p.subtract_value(index)
    assert !(p.columns[p.calculate_column(index)].include? value)
  end

  def test_valid?
    p = Sudoku::Puzzle.new
    p[23] = "4"
    p[22] = "3"
    assert p.valid?
  end

  def test_complete?
    p = Sudoku::Puzzle.new
    p[23] = "4"
    p[22] = "3"
    assert !p.complete?
  end

  def test_dup
    c = Sudoku::Creator.new
    c.create_base
    c2 = c.dup
    assert_equal c.puzzle, c2.puzzle
    c2[34] = "."
    assert c.puzzle != c2.puzzle
  end


end
