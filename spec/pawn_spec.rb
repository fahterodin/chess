require './lib/pawn.rb'

describe Pawn do
  describe '#possible_moves' do
    context 'the pawn is moved for the first time' do
      subject(:pawn) { described_class.new([1, 1], 'white') }

      it 'gives the player all the possible moves' do
        possible_moves = [[1, 2], [1, 3]]

        expect(pawn.possible_moves).to eq(possible_moves)
      end
    end

    context 'the pawn is moved after the first time' do
      subject(:pawn) { described_class.new([3, 5], 'white') }
      
      it 'gives the player the only possible move' do
        possible_moves = [[3, 6]]
        pawn.instance_variable_set(:@start_position, [3, 1])

        expect(pawn.possible_moves).to eq(possible_moves)
      end
    end
  end
end
