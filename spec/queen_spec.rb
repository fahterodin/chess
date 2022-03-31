require './lib/queen.rb'

describe Queen do
  describe '#possible_moves' do
    context 'the player ask to move the queen' do
      subject(:queen) { described_class.new([5, 2], 'black') }

      it 'list the possible moves' do
        moves = [[[6, 2], [7, 2]], [[5, 1], [5, 0]], [[4, 2], [3, 2], [2, 2], [1, 2], [0, 2]], [[5, 1], [5, 0]], [[6, 3], [7, 4]], [[6, 1], [7, 0]], [[4, 3], [3, 4], [2, 5], [1, 6], [0, 7]], [[4, 1], [3, 0]]]

        expect(queen.possible_moves).to eq(moves)
      end
    end
  end
end
