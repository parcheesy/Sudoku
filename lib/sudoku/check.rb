#### Method for checking a puzzle against a solution,
#### returning an array with trues where puzzle is correct
#### and false where puzzle is incorrect
module Sudoku

  def Sudoku.check(puzzle, solution)
    # Check that first argument is a puzzle and second argument is a solver object
    raise "Entered solution must be a Sudoku::Solver object." unless solution.is_a? Sudoku::Solver
    raise "Entered puzzle must be a Sudoku::Puzzle object." unless puzzle.is_a? Sudoku::Puzzle
   
    p = puzzle.puzzle
    s = solution.puzzle
    
    # Loop through both the puzzle and solution
    # return an array with trues when they match
    # and falses when they don't
    check = p.zip(s).map do |entry, solution|
              entry==solution ? true : false  
            end

    # Return the array of trues and falses
    return check
  end

end
