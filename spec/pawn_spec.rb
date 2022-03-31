require './lib/pawn.rb'

describe Pawn do
  describe '#possible_moves' do
    context 'the pawn is moved for the first time' do
      subject(:pawn) { described_class.new([1, 1], 'W') }

      it 'gives the player all the possible moves' do
        possible_moves = [[[1, 2], [1, 3]]]

        expect(pawn.possible_moves).to match_array(possible_moves)
      end
    end

    context 'the pawn is moved after the first time' do
      subject(:pawn) { described_class.new([3, 5], 'W') }
      
      it 'gives the player the possible move' do
        pawn.instance_variable_set(:@first_move, false)
        possible_moves = [[[3, 6]]]
       
        expect(pawn.possible_moves).to match_array(possible_moves)
      end
    end
  end

  describe '#possible_eat' do
    context 'the method is called' do
      subject(:pawn) { described_class.new([1, 1], 'B') }

      it 'return the possible eat' do
        eat = [[[0, 0]], [[2, 0]]]
        expect(pawn.possible_eat).to match_array(eat)
      end
    end
  end
end
