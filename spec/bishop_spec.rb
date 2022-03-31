require './lib/bishop.rb'

describe Bishop do
  describe '#possible_moves' do
    context 'the player ask to move the bishop' do
      subject(:bishop) { described_class.new([4, 7], 'B') }

      it 'list the possible moves' do
        moves = [[], [[5, 6], [6, 5], [7, 4]], [], [[3, 6], [2, 5], [1, 4], [0, 3]]]

        expect(bishop.possible_moves).to eq(moves)
      end

      it 'consistency when called two times' do
        moves = [[], [[5, 6], [6, 5], [7, 4]], [], [[3, 6], [2, 5], [1, 4], [0, 3]]]

        expect(bishop.possible_moves).to match_array(moves)
        expect(bishop.possible_moves).to match_array(moves)
      end
    end
  end
end
