# frozen_string_literal: true

require './lib/board.rb'

describe Board do
  describe '#initialize' do
    context 'a new board is created' do
      subject(:board) { described_class.new }

      xit 'should return an array of 8 elements each containing 8 nil elements' do
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

  describe '#initialize' do
    context 'the object is created' do
      subject(:board) { described_class.new }

      it 'populate a board of pieces' do
        expect(board.row(0)[0]).to be_a(Rook)
        expect(board.row(7)[5]).to be_a(Bishop)
        expect(board.row(3)[2]).to be_a(EmptySquare)
      end
    end
  end
end
