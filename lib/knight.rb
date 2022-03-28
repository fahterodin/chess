require_relative 'piece'

class Knight
  attr_reader :position, :player, :name

  include Piece

  def initialize(position, player)
    @position = position
    @player = player
    @moves = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
    @name = 'L'
  end

  def possible_moves
    possible_moves = @moves
    possible_moves.map do |move|
      move[0] += @position.first
      move[1] += @position.last
    end
    legal_moves(possible_moves)
  end
end
