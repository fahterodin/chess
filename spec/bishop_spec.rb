require './lib/bishop.rb'

describe Bishop do
  describe '#possible_moves' do
    context 'the player ask to move the bishop' do
      subject(:bishop) { described_class.new([4, 7], 'black') }

      it 'list the possible moves' do
        moves = [[3, 6], [2, 5], [1, 4], [0, 3], [5, 6], [6, 5], [7, 4]]

        expect(bishop.possible_moves).to match_array(moves)
      end
    end
  end
end
