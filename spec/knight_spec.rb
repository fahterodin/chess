require './lib/knight.rb'

describe Knight do
  describe '#possible_moves' do
    context 'the player ask to move the knight' do
      subject(:knight) { described_class.new([1, 6], 'white') }

      it 'list all the possible moves' do
        moves = [[3, 7], [0, 4], [2, 4], [3, 5]]

        expect(knight.possible_moves).to match_array(moves)
      end
    end
  end
end
