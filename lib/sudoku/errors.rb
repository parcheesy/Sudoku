#### Create custom errors for Sudoku module

module Sudoku

  #Invalid error
  #Should be used when entry or value is invalid
  class Invalid < StandardError
  end

  #Impossible error
  #Should be used when puzzle is impossible to solve because
  #It is overconstrained
  #Meaning there is either no solution or multiple solutions
  class Impossible < StandardError
  end

  class MultipleSolutions < StandardError
  end

end
