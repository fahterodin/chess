# frozen_string_literal: true

# will add eat moves later

require_relative 'piece'

class Pawn
  attr_reader :position

  include Piece

  def initialize(position, player)
    @moves = [[0, 1], [0, 2]]
    @eat = [[-1, 1], [1, 1]]
    @position = position
    @start_position = position
    @player = player
  end

  def possible_moves
    possible_moves = []
    if @start_position == @position
      possible_moves = @moves
    else
      possible_moves << @moves.first
    end
    possible_moves.map do |move|
      move[0] += @position.first
      move[1] += @position.last
    end
    legal_moves(possible_moves)
  end
end
