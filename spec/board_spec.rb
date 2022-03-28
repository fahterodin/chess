# frozen_string_literal: true

require './lib/board.rb'

describe Board do
  describe '#initialize' do
    context 'a new board is created' do
      subject(:board) { described_class.new }

      it 'should return an array of 8 elements each containing 8 nil elements' do
        grid = 
          [[nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil]]

        expect(board.grid).to eq(grid)
      end
    end
  end
end
