require_relative 'piece'

class Queen
  attr_reader :position, :player, :name

  include Piece

  def initialize(position, player)
    @position = position
    @player = player
    @moves = populate
    @name = 'Q'
  end

  def possible_moves
    possible_moves = @moves
    possible_moves.map do |move|
      move[0] += @position.first
      move[1] += @position.last
    end
    legal_moves(possible_moves)
  end

  def change_position(coordinates)
    @position = coordinates
  end

  private

  def populate
    moves = []
    for i in 1..7 do
      moves.push([i, 0], [0, i], [-i, 0], [0, -i], [i, i], [i, -i], [-i, i], [-i, -i])
    end
    moves
  end
end
