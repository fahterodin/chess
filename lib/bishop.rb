require_relative 'piece'

class Bishop
  attr_reader :position, :player, :name

  include Piece

  def initialize(position, player)
    @position = position
    @player = player
    @moves = populate
    @name = 'B'
  end

  def possible_moves
    calculate_moves(Array.new(4) { Array.new }, @moves)
  end

  private

  def populate
    moves = Array.new(4) { Array.new }
    for i in 1..7 do
      moves[0].push([i, i])
      moves[1].push([i, -i])
      moves[2].push([-i, i])
      moves[3].push([-i, -i])
    end
    moves.freeze
  end
end
