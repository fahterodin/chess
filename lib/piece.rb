module Piece
  def legal_moves(moves)
    moves.select do |move|
      move if move.all? { |n| n >= 0 && n <= 7 }
    end
  end
end
