#### Creator Class for creating a Sudoku Puzzle from scratch
module Sudoku

  class Creator < Puzzle

    def initialize
      super 
    end

    #Creates a valid base puzzle with entries 1-9 at each spot
    def create_base
      #Uses the rotating numbers iterator to create nine basic valid rows
      #Each row is entered into the puzzle using the array access operator defined
      #in the Puzzle class
      rotating_numbers do |row, values|
        index = row * 9
        values.each do |value|
          self[index] = value
          index += 1
        end
      end
    end

    #Randomizes the already created base by applying a random reflection 1000 times
    def randomize_base
     #Check that base was already created
     raise "Must create base first using 'create_base' method." unless self.complete?
     #An array of the four reflect methods
     random_methods = [method(:reflect_horizontal), method(:reflect_vertical), method(:reflect_major_diagonal), method(:reflect_minor_diagonal)]
     #Randomly call one of the reflect methods 1000 times
     1000.times do
       random_methods.shuffle[0].call
     end
    end

    #Rotate through rows by 3
    #Each time shifting the ordered choices 1-9 by one
    #Starting row is randomized
    #Creates an iterator that provides a row and rotated array of numbers at each iteration
    #Going through all nine iterations results in nine basic valid sudoku rows
    def rotating_numbers
      numbers = @choices.dup
      #Randomize starting row
      x = rand(0..8)
      #Array of row indexes starting at the random row
      #Moves up by three until the end of the puzzle
      #Then goes back to the row after the starting point and repeats
      #Then goes back to the row two after the starting point and repeats
      #The result is an array traveling through the rows by hitting
      #the same row in each box first
      row_order = [x, (x+3)%9,(x+6)%9, (x+1)%9, (x+4)%9, (x+7)%9, (x+2)%9, (x+5)%9, (x+8)%9]
      row_order.each do |row|
        yield row, numbers
        numbers = rotate_array(numbers)
      end
    end

    #Shifts the array right by 1
    #With the last entry rotating back to the first entry
    def rotate_array(ar)
      new_ar = [0] * ar.length
      0.upto(ar.length - 1) do |index|
        new_index = (index + 1) % ar.length
        new_ar[new_index] = ar[index]
      end
      return new_ar
    end

    #Rotates the puzzle horizontally about row 4
    def reflect_horizontal
      0.upto 8 do |column|
        upper_pointer = 8
        lower_pointer = 0
        while upper_pointer != lower_pointer
          temp = self.matrix_find(lower_pointer, column)
          self.matrix_replace(lower_pointer, column, self.matrix_find(upper_pointer, column))
          self.matrix_replace(upper_pointer, column, temp)
          lower_pointer += 1
          upper_pointer -= 1
        end
      end
    end

    #Rotates the puzzle vertically about column 4
    def reflect_vertical
      0.upto 8 do |row|
        upper_pointer = 8
        lower_pointer = 0
        while upper_pointer != lower_pointer
          temp = self.matrix_find(row, lower_pointer)
          self.matrix_replace(row, lower_pointer, self.matrix_find(row, upper_pointer))
          self.matrix_replace(row, upper_pointer, temp)
          lower_pointer += 1
          upper_pointer -= 1
        end
      end
    end


    #Rotates the puzzle about the major diagonal(top left to bottom right)
    def reflect_major_diagonal
      0.upto 8 do |column|
        0.upto column do |row|
          if row != column
            temp = self.matrix_find(row, column)
            self.matrix_replace(row, column, self.matrix_find(column, row))
            self.matrix_replace(column, row, temp)
          end
        end
      end
    end

    #Rotates the puzzle about the minor diagonal(top right to bottom left)
    def reflect_minor_diagonal
      0.upto 8 do |column|
        diagonal = 8-column
        0.upto diagonal  do |row|
          if row != diagonal
            temp = self.matrix_find(row, column)
            self.matrix_replace(row, column, self.matrix_find(8-column, 8-row))
            self.matrix_replace(8-column, 8-row, temp)
          end
        end
      end
    end
   
  end

end
