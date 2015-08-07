#### A Sudoku method for creating a puzzle with a given number of missing entries.
#### Will return an array with the puzzle in the 0 index.
#### The 1 index will be true if a puzzle was able to be made with the given number
#### of missing entries and false if it could not make a puzzle with the given number
#### of missing entries.  If it returns false, the accompanying puzzle will be the 
#### a puzzle with the greatest number of missing entries it could accomplish in a reasonable
#### amount of time.
#### WARNING: Asking for more than 56 missing entries will likely return false and take an
#### unwiedly amount of time.
module Sudoku

  def Sudoku.make(missing_entries)
    #Raise error if argument is not an integer
    raise "Enter integer for number of missing entries requested." unless missing_entries.class==Fixnum 
    #Create a randomized complete Sudoku::Solver object 
    c = Creator.new
    c.create_base
    c.randomize_base
    s = Solver.new(c)
    saved_solution = s.dup

    #Add an empty '.' slot the number of times indicated
    missing_entries.times do
      #Keep track if a solvable puzzle is created
      solution = false
      #Try a 1000 times to place a single "." to conserve time
      1000.times do
        #Choose random index to place "."
        index = rand(0..80)      
        #Check is "." is already at index
        if s[index] != "."
          #Store copy of puzzle before placing "." in case an invalid puzzle is created
          prev = s.dup
          s[index] = "."
          begin
            #If the puzzle is solvable with the additional "." break out of the attempts
            solve(s)
            solution = true
            break
          rescue Impossible, MultipleSolutions
            #If an Impossible or MultipleSolutions error is raised
            #return the puzzle to its state before adding the "."
            s = prev
            next
          end
        end
      end
      
      #If 1000 tries was not enough to successfully place an additional "."
      #return the puzzle as it is with false, indicating a failure
      unless solution
        return s, saved_solution, false
      end
    end
    #If the proper number of missing entries were added return the resulting puzzle
    #with true to indicating a success
    return s, saved_solution, true

  end

end
