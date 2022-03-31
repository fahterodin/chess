# frozen_string_literal: true

module Piece
  def legal_moves(moves)
    moves.each do |direction|
      direction.select! do |coordinate|
        coordinate.all? { |n| n >= 0 && n <= 7 }
      end
    end
  end
  
  def calculate_moves(array, moves)
    possible_moves = array
    moves.each_with_index do |direction, idx|
      direction.each do |coordinate|
        possible_moves[idx] << [coordinate.first + @position.first, coordinate.last + @position.last]
      end
    end
    legal_moves(possible_moves)
  end

  def update_position(position)
    @position = position
  end
end
