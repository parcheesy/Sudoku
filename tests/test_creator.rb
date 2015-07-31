require "./lib/sudoku"
require "test/unit"

class TestCreator< Test::Unit::TestCase

  def test_create_base
    c = Sudoku::Creator.new
    c.create_base
    assert c.valid? && c.complete?
  end


  def test_reflect_horizontal
    c = Sudoku::Creator.new
    c.create_base
    first_row = c.puzzle[0..8]
    c.reflect_horizontal
    assert_equal first_row, c.puzzle[72..80]
  end

  def test_reflect_vertical
    c = Sudoku::Creator.new
    c.create_base
    indexes = []
    0.upto(8) { |i| indexes.push(i*9) }
    first_column = indexes.map {|i| c.puzzle[i]}
    c.reflect_vertical
    indexes = indexes.map {|i| i + 8 }
    new_last_column = indexes.map {|i| c.puzzle[i]}
    assert_equal first_column, new_last_column
  end

  def test_reflect_major_diagonal
    c = Sudoku::Creator.new
    c.create_base
    value = c.matrix_find(3, 7)
    c.reflect_major_diagonal
    new_value = c.matrix_find(7, 3)
    assert_equal value, new_value
  end

  def test_reflect_minor_diagonal
    c = Sudoku::Creator.new
    c.create_base
    value = c.matrix_find(0, 7)
    c.reflect_minor_diagonal
    new_value = c.matrix_find(1, 8)
    assert_equal value, new_value
  end

  def test_randomize_base
    c = Sudoku::Creator.new
    c.create_base
    current_puzzle = c.dup
    c.randomize_base
    new_puzzle = c
    assert current_puzzle != new_puzzle
  end

end

