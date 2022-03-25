require_relative 'piece'

class King
  attr_reader :player, :position

  include Piece
  
  def initialize(position, player)
    @position = position
    @player = player
    @moves = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
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