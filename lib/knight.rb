require_relative 'piece'

class Knight
  attr_reader :position, :player, :name, :display

  include Piece

  def initialize(position, player)
    @position = position
    @player = player
    @moves = [[[2, 1]], [[1, 2]], [[-1, 2]], [[-2, 1]], [[-2, -1]], [[-1, -2]], [[1, -2]], [[2, -1]]].freeze
    @name = 'L'
    @display = display_symbol
  end

  def possible_moves
    calculate_moves(Array.new(8) { Array.new }, @moves)
  end

  private

  def display_symbol
    @player == 'W' ? '♘' : '♞'
  end
end
