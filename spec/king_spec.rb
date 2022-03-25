require './lib/king.rb'

describe King do
  describe '#possible_moves' do
    context 'the player ask to move the king' do
      subject(:king) { described_class.new([3, 3], 'white') }

      it 'list all the possible moves' do
        moves = [[4, 3], [4, 4], [3, 4], [2, 4], [2, 3], [2, 2], [3, 2], [4, 2]]

        expect(king.possible_moves).to eq(moves)
      end
    end
  end
end
