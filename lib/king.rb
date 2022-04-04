# frozen_string_literal: true

require_relative 'piece'

class King
  attr_reader :player, :position, :name, :display

  include Piece

  def initialize(position, player)
    @position = position
    @player = player
    @moves = [[[1, 0]], [[1, 1]], [[0, 1]], [[-1, 1]], [[-1, 0]], [[-1, -1]], [[0, -1]], [[1, -1]]].freeze
    @name = 'K'
    @display = display_symbol
  end

  def possible_moves
    calculate_moves(Array.new(8) { Array.new }, @moves)
  end

  private

  def display_symbol
    @player == 'W' ? '♔' : '♚'
  end
end
