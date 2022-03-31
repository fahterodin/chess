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
    calculate_moves(Array.new(8) { Array.new }, @moves)
  end

  private

  def populate
    moves = Array.new(8) { Array.new }
    for i in 1..7 do
      moves[0].push([i, 0])
      moves[1].push([0, -i])
      moves[2].push([-i, 0])
      moves[3].push([0, -i])
      moves[4].push([i, i])
      moves[5].push([i, -i])
      moves[6].push([-i, i])
      moves[7].push([-i, -i])
    end
    moves.freeze
  end
end
