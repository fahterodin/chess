require './lib/rook.rb'

describe Rook do
  describe '#possible_moves' do
    context 'the player ask to move the rook' do
      subject(:rook) { described_class.new([2, 6], 'white') }

      it 'list all the possible moves' do
        moves = [[1, 6], [0, 6], [3, 6], [4, 6], [5, 6], [6, 6], [7, 6], [2, 7], [2, 5], [2, 4], [2, 3], [2, 2], [2, 1], [2, 0]]

        expect(rook.possible_moves).to match_array(moves)
      end
    end
  end
end
