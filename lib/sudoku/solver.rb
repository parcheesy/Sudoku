#### A Sudoku Solver
#### When initialize make sure to enter the puzzle as a
#### Creator object, Array, or String with entries being
#### 1 through 9 or a '.' to signify an unknown entry
#### The puzzle must have 81 entries
module Sudoku

  class Solver < Puzzle

    attr_reader :cells_string

    def initialize(cells)
      super()
      
      #If the cells entered are in the form of a Creator object
      #Just fill the puzzle with the Creator object entries
      if cells.class==Sudoku::Creator
        cells.puzzle.each_with_index do |entry, index|
          self[index] = entry
        end

      #If the cells entered are in the form of an array
      #Check that it contains 81 entries
      #Go through each cell and enter it into the puzzle as a string
      #Raise an Invalid error if an entry isn't a valid choice
      elsif cells.class==Array
        #Check if Array has 81 spots
        raise Invalid, "Wrong size puzzle. Make sure puzzle has 81 spots." unless cells.length == 81
        cells.each_with_index do |entry, index|
          entry = entry.to_s
          #Must be a choice 1-9 or a period indicating an empty entry
          raise Invalid, "Invalid entry at index #{index}." unless (@choices + ["."]).include? entry
          #Uses the array access assignment operator
          #This will place the entry into the puzzle and 
          #The proper rows, columns, and boxes
          self[index] = entry
        end

      #If the cells entered are in the form of a string
      #Remove all white spaces
      #Check that it has 81 entries
      elsif cells.class==String
        #Get rid of white spaces
        cells_string = cells.dup.gsub!(/\s/, "")
        #Check if String has 81 entries
        raise Invalid, "Wrong size puzzle. Make sure puzzle has 81 spots." unless cells.length == 81
        cells.split("").each_with_index do |entry, index|
          #Each entry must be a choice 1-9 or a period indicating an empty space
          raise Invalid, "Invalid entry at index #{index}." unless (@choices + ["."]).include? entry
          #Uses the array access assignment operator
          #This will place the entry into the puzzle and
          #The proper rows, columns, and boxes
          self[index] = entry
        end
      else
        raise Invalid,  "Not a puzzle Creator object, array, or string."         
      end

    end

    #Return options at a given index based on entries already in row, column, and box
    def check_options(index)
      options = @choices.dup
      row = calculate_row(index)
      column = calculate_column(index)
      box = calculate_box(index) 
      options - ["."] -  @rows[row] - @columns[column] - @boxes[box] 
    end


    def make_choice(index)
      choice = check_options(index).sample
      if choice
        @puzzle[index] = choice
        @rows[calculate_row(index)] << choice
        @columns[calculate_column(index)] << choice
        @boxes[calculate_box(index)] << choice
      else
        raise Invalid
      end
    end


    #Return each unknown entry as an iterator
    def each_unknown
      0.upto 80 do |index|
        next if self[index] != "."
        yield index
      end
    end

  end


end


