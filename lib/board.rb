# frozen_string_literal: true

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def row(n)
    case n
    when 0
      row = @grid[0]
    when 1
      row = @grid[1]
    when 2
      row = @grid[2]
    when 3
      row = @grid[3]
    when 4
      row = @grid[4]
    when 5
      row = @grid[5]
    when 6
      row = @grid[6]
    when 7
      row = @grid[7]
    end
    row
  end
end
