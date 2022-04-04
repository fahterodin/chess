require_relative 'piece'

class Rook
  attr_reader :position, :player, :name, :display

  include Piece

  def initialize(position, player)
    @position = position
    @player = player
    @moves = populate
    @name = 'R'
    @display = display_symbol
  end

  def possible_moves
    calculate_moves(Array.new(4) { Array.new }, @moves)
  end

  private

  def populate
    moves = Array.new(4) { Array.new }
    for i in 1..7 do
      moves[0].push([i, 0])
      moves[1].push([0, -i])
      moves[2].push([-i, 0])
      moves[3].push([0, -i])
    end
    moves.freeze
  end

  def display_symbol
    @player == 'W' ? '♖' : '♜'
  end
end
