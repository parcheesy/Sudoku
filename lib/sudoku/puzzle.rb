#### Puzzle class for Sudoku Module
#### Serves as prototype for Creator and Solver classes
#### Sets up essential attributes and methods for Sudoku Puzzle


module Sudoku

  #Puzzle prototype for creator and solver
  class Puzzle
    
    attr_reader :choices, :puzzle, :rows, :columns, :boxes
    #Initializes choices, puzzle, rows, columns, and boxes
    def initialize
      @choices = %w(1 2 3 4 5 6 7 8 9)
      @puzzle = [0] * 81
      @rows = [[], [], [], [], [], [], [], [], []]
      @columns = [[], [], [], [], [], [], [], [], []] 
      @boxes = [[], [], [], [], [], [], [], [], []]
    end

    #Array access operator for puzzle that returns value and specified index
    #Used with following syntax:
    #puzzle_instance[index]
    def [](index)
      @puzzle[index]
    end

    #Array access operator for assigning values at specified index
    #Used with following syntax:
    #puzzle_instance[index] = newvalue
    def []=(index, newvalue)
      newvalue = newvalue.to_s
      unless (@choices + ["."]).include? newvalue
        raise Invalid, "Illegal Value"
      end
      #Calls subtract_value method to remove
      #the current value from its row, column, and box
      subtract_value(index)
      #Calls add_value method to add new value
      #to puzzle and add it to proper row, column, and box
      add_value(index, newvalue)
    end

    #Alternate method of returning value at specified index
    #Using row and column of puzzle matrix
    def matrix_find(row, column)
      self[row*9 + column]
    end

    #Alternate method of assigning value at specified index
    #Using row and column of puzzle matrix
    def matrix_replace(row, column, newvalue)
      self[row*9 + column] = newvalue
    end

    #Add value method for adding value to index
    #And proper row, column, and box
    def add_value(index, newvalue)
      @puzzle[index] = newvalue
      if newvalue != "."
        @rows[calculate_row(index)] << newvalue
        @columns[calculate_column(index)] << newvalue
        @boxes[calculate_box(index)] << newvalue
      end
    end

    #Subtract value method for removing current value
    #From proper row, column, and box
    def subtract_value(index)
      val = @puzzle[index]
      if val != "."
        row = @rows[calculate_row(index)]
        row.delete_at(row.index(val) || row.length)

        column = @columns[calculate_column(index)]
        column.delete_at(column.index(val) || column.length)

        box = @boxes[calculate_box(index)]
        box.delete_at(box.index(val) || box.length)
      end
    end

    #Check if current puzzle is valid
    #Valid means there are no duplicate values in rows, columns, or boxes
    #Returns true if valid, false if not
    def valid?
      0.upto(8) { |row| return false if @rows[row].uniq! }
      0.upto(8) { |column| return false if @columns[column].uniq! }    
      0.upto(8) { |box| return false if @boxes[box].uniq! }

      return true
    end

    #Check if current puzzle is complete
    #Complete means there is a valid entry at every index
    #And each row, column, and box has a complete set of values 1-9
    #Returns true if complete, false if not
    def complete?
      @puzzle.each do |entry|
        return false unless @choices.include? entry
      end

      0.upto(8) do |n|
        return false if @rows[n].sort!=@choices || @columns[n].sort!=@choices || @boxes[n].sort!=@choices
      end

      return true
    end

    #Resets the puzzle, rows, columns, and boxes completely
    #WARNING:Cannot be undone
    def clear_puzzle
      @puzzle = [0] * 81
      @rows = [[], [], [], [], [], [], [], [], []]
      @columns = [[], [], [], [], [], [], [], [], []] 
      @boxes = [[], [], [], [], [], [], [], [], []]
    end

    #Calculate proper row for index
    def calculate_row(index)
      index/9
    end
    
    #Calculate proper column for index
    def calculate_column(index)
      index % 9
    end

    #Calculate proper box for index
    def calculate_box(index)
      (calculate_row(index) % 3) * 3 + (calculate_column(index) % 3)
    end

    #Override to_s method so that puzzle is displayed as a neat matrix
    def to_s
      returned_str = ""
      @puzzle.each_with_index do |entry, i|
        returned_str += "\n" if (i%9)==0
        returned_str +=  entry.to_s + " "
      end
      returned_str 
    end

    #Override dup method to create new copies of
    #puzzle, rows, columns, and boxes as well
    def dup
      copy = super
      copy.clear_puzzle
      @puzzle.each_with_index do |entry, index|
        copy[index] = entry
      end
      copy
    end

  end

end
