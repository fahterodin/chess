require_relative 'piece'

class Bishop
  attr_reader :position, :player

  include Piece

  def initialize(position, player)
    @position = position
    @player = player
    @moves = populate
  end

  def possible_moves
    possible_moves = @moves
    possible_moves.map do |move|
      move[0] += @position.first
      move[1] += @position.last
    end
    legal_moves(possible_moves)
  end

  def populate
    moves = []
    for i in 1..7 do
      moves.push([i, i], [i, -i], [-i, i], [-i, -i])
    end
    moves
  end
end
