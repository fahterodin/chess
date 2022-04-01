require_relative 'rook'
require_relative 'knight'
require_relative 'empty_square'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
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

  def display
    i = 7
    until i.negative?
      print " #{i}"
      row(i).each do |piece|
        print "| #{piece.name}-#{piece.player} "
      end
      print "\n"
      i -= 1
    end
    print "     0  |  1  |  2  |  3  |  4  |  5  |  6  |  7 \n"
  end

  private

  def populate
    @grid[0] = [Rook.new([0, 0], 'W'),Knight.new([1, 0], 'W'), Bishop.new([2, 0], 'W'), Queen.new([3, 0], 'W'), King.new([4, 0], 'W'), Bishop.new([5, 0], 'W'), Knight.new([6, 0], 'W'), Rook.new([7, 0], 'W')]
    @grid[1] = [Pawn.new([0, 1], 'W'), Pawn.new([1, 1], 'W'), Pawn.new([2, 1], 'W'), Pawn.new([3, 1], 'W'), Pawn.new([4, 1], 'W'), Pawn.new([5, 1], 'W'), Pawn.new([6, 1], 'W'), Pawn.new([7, 1], 'W')]
    @grid[2] = [EmptySquare.new([0, 2]), EmptySquare.new([1, 2]), EmptySquare.new([2, 2]), EmptySquare.new([3, 2]), EmptySquare.new([4, 2]), EmptySquare.new([5, 2]), EmptySquare.new([6, 2]), EmptySquare.new([7, 2])]
    @grid[3] = [EmptySquare.new([0, 3]), EmptySquare.new([1, 3]), EmptySquare.new([2, 3]), EmptySquare.new([3, 3]), EmptySquare.new([4, 3]), EmptySquare.new([5, 3]), EmptySquare.new([6, 3]), EmptySquare.new([7, 3])]
    @grid[4] = [EmptySquare.new([0, 4]), EmptySquare.new([1, 4]), EmptySquare.new([2, 4]), EmptySquare.new([3, 4]), EmptySquare.new([4, 4]), EmptySquare.new([5, 4]), EmptySquare.new([6, 4]), EmptySquare.new([7, 4])]
    @grid[5] = [EmptySquare.new([0, 5]), EmptySquare.new([1, 5]), EmptySquare.new([2, 5]), EmptySquare.new([3, 5]), EmptySquare.new([4, 5]), EmptySquare.new([5, 5]), EmptySquare.new([6, 5]), EmptySquare.new([7, 5])]
    @grid[7] = [Rook.new([0, 7], 'B'),Knight.new([1, 7], 'B'), Bishop.new([2, 7], 'B'), Queen.new([3, 7], 'B'), King.new([4, 7], 'B'), Bishop.new([5, 7], 'B'), Knight.new([6, 7], 'B'), Rook.new([7, 7], 'B')]
    @grid[6] = [Pawn.new([0, 6], 'B'), Pawn.new([1, 6], 'B'), Pawn.new([2, 6], 'B'), Pawn.new([3, 6], 'B'), Pawn.new([4, 6], 'B'), Pawn.new([5, 6], 'B'), Pawn.new([6, 6], 'B'), Pawn.new([7, 6], 'B')]
  end
end
