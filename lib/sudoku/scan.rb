#### Scan and solve a Sudoku Puzzle
#### Puzzle must be initialized as a Sudoku::Solver object
#### before being passed to Sudoku.solve or Sudoku.scan
require 'digest'
module Sudoku

  #Method for creating md5 hash from sudoku puzzle
  def Sudoku.md5(obj)
    Digest::MD5.hexdigest(obj.to_s)
  end


  #Scanner that scans Sudoku::Solver object
  #Goes through each unknown spot in puzzle
  #If there are no possible options at a spot an Impossible error is raised
  #If 1 option is available at a spot the puzzle is filled with that option
  #If more than 1 option is available at a spot 
  #the index and set of choices of the spot with the fewest choices is stored
  #and returned
  def Sudoku.scan(puzzle)
    #Check that puzzle is a Sudoku::Solver object
    raise "Entered puzzle must be Sudoku::Solver object." unless puzzle.class==Sudoku::Solver

    unchanged = false
    
    #Continue looping until we go through a loop
    #where no changes are made
    until unchanged
      unchanged = true
      min_index, min_set = nil 
      min = 10
      #Loop through each unknown spot in puzzle
      puzzle.each_unknown do |index|
        #Check options at index
        choices = puzzle.check_options(index)

        case choices.size
       
        #If no choices are available at an unkown spot
        #it means the puzzle is overconstrained and cannot
        #be solved. So raise an Impossible error
        when 0
          raise Impossible, "This puzzle is overconstrained"
        #If there is only one choice, it is the correct solution
        #So add the choice to the puzzle at the index
        #and mark that the puzzla has been changed so that the 
        #while loop repeats allowing us to analyze unknown spots
        #using the updated puzzle
        when 1
          puzzle[index] = choices[0]
          unchanged = false
        #If there is more than one choice 
        #check if the puzzle hasn't been changed
        #and the current spot has less choices
        #than any spot yet. If those tests pass store
        #the index and set
        else
          if unchanged && choices.size < min
            min = choices.size
            min_index, min_set = index, choices
          end
        end
      end
    end
    #After going through all unknown spots without anything
    #being changed, return the index and set of choices
    #for the spot with the minimum number of choices
    return min_index, min_set
  end

  #Method for solving a Sudoku puzzle (must be a Sudoku::Solver object)
  #Scans the puzzle, returning a solved puzzle or
  #raising an Impossible error if the puzzle can't be solved
  def Sudoku.solve(puzzle)
    #Raise error if passed puzzle is not a Sudoku::Solver object
    raise "Entered puzzle must be Sudoku::Solver object." unless puzzle.class==Sudoku::Solver

    #Create a duplication of the puzzle so changes aren't made to the original
    puzzle = puzzle.dup

    #Scan the puzzle
    index, choices = scan(puzzle)
    
    #If the scan returns nil, the puzzle has been solved
    #So return the puzzle
    return puzzle if index==nil


    #Hash table for storing solutions
    solutions = {}
    #If the scan returns choices go through those choices
    choices.each do |guess|
      #Make a guess for each of those choices by entering 
      #the choice into the puzzle
      puzzle[index] = guess

      #Recursively solve the puzzle with the entered guess
      begin 
        #Attempt to solve the puzzle
        solution = solve(puzzle)
        #If the puzzle is solved, find its md5 hash and store it in the table
        #This will store different solutions and overwrite identical solutions
        solutions[md5(solution)] =  solution
      rescue Impossible
        #If the guess causes an impossible puzzle
        #try the next guess
        next
      end
    end
    #Check the solutions hash length
    case solutions.length
    #If there are no solutions the puzzle is impossible, raise an error 
    when 0
      raise Impossible, "No Solution."
    #If there is only one solution the puzzle is a valid sudoku puzzle
    #so return the puzzle
    when 1
      return solutions.values[0]
    #If there is more than one solution the puzzle is invalid
    #Raise a MultipleSolutions error
    else
      raise MultipleSolutions, "Multiple Solutions."
    end
  end


end


