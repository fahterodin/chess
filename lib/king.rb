# frozen_string_literal: true

require_relative 'piece'

class King
  attr_reader :player, :position, :name

  include Piece

  def initialize(position, player)
    @position = position
    @player = player
    @moves = [[[1, 0]], [[1, 1]], [[0, 1]], [[-1, 1]], [[-1, 0]], [[-1, -1]], [[0, -1]], [[1, -1]]].freeze
    @name = 'K'
  end

  def possible_moves
    calculate_moves(Array.new(8) { Array.new }, @moves)
  end
end
