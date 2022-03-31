require './lib/piece.rb'

describe Piece do
  describe '#legal_moves' do
    context 'a set of possible move is given' do
      let(:dummy) { Class.new { extend Piece } }

      it 'returns an array containing only the legal moves' do
        moves = [[[1, 1], [2, 5]], [[5, 9], [-3, 14]], [[0, 7]]]
        legal_moves = [[[1, 1], [2, 5]], [], [[0, 7]]]

        expect(dummy.legal_moves(moves)).to eq(legal_moves)
      end
    end
  end
end
