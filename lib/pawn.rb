# frozen_string_literal: true

require_relative 'piece'

class Pawn
  attr_reader :position, :player, :name, :display

  include Piece

  def initialize(position, player)
    @moves_white = [[0, 1], [0, 2]].freeze
    @eat_white = [[[-1, 1]], [[1, 1]]].freeze
    @moves_black = [[0, -1], [0, -2]].freeze
    @eat_black = [[[-1, -1]], [[1, -1]]].freeze
    @position = position
    @player = player
    @name = 'P'
    @first_move = true
    @display = display_symbol
  end

  def possible_moves
    moves = []
    case @player
    when 'W'
      if @first_move == true
        moves[0] = @moves_white
      else
        moves[0] = [@moves_white[0]]
      end
    when 'B'
      if @first_move == true
        moves[0] = @moves_black
      else
        moves[0] = [@moves_black[0]]
      end
    end
    @first_move = false
    calculate_moves(Array.new(1) { Array.new }, moves)
  end

  def possible_eat
    case @player
    when 'W'
      calculate_moves(Array.new(2) { Array.new }, @eat_white)
    when 'B'
      calculate_moves(Array.new(2) { Array.new }, @eat_black)
    end
  end

  private

  def display_symbol
    @player == 'W' ? '♙' : '♟'
  end
end
