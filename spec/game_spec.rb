require './lib/game.rb'

describe Game do
  describe '#ask_input' do
    context 'the player gives valid input' do
      subject(:game) { described_class.new }

      before do
        allow(game).to receive(:puts).at_least(4).times
        allow(game).to receive(:gets).and_return('2', '3')
      end

      it 'returns valid coordinates' do
        valid_coordinates = [2, 3]
        expect(game.ask_input).to eq(valid_coordinates)
      end
    end
    context 'the player gives invalid input' do
      subject(:game) { described_class.new }

      before do
        allow(game).to receive(:puts).at_least(4).times
        allow(game).to receive(:gets).and_return('a', '3')
      end

      it 'returns error message' do
        expect(game).to receive(:puts).with('Wrong input!').once
        game.ask_input
      end
    end
    context 'the player gives a valid input but outside the board' do
      subject(:game) { described_class.new }

      before do
        allow(game).to receive(:puts).at_least(4).times
        allow(game).to receive(:gets).and_return('9', '3')
      end

      it 'returns error messagge' do
        expect(game).to receive(:puts).with('Choose number between 0 and 7').once
        game.ask_input
      end
    end
  end
end

