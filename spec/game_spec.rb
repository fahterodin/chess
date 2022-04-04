require './lib/game.rb'

describe Game do
  describe '#ask_input' do
    context 'the player gives valid input' do
      subject(:game) { described_class.new }

      before do
        allow(game).to receive(:puts).at_least(2).times
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
        allow(game).to receive(:puts).at_least(2).times
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
        allow(game).to receive(:puts).at_least(2).times
        allow(game).to receive(:gets).and_return('9', '3')
      end

      xit 'returns error message' do
        expect(game).to receive(:puts).with('Choose number between 0 and 7').once
        game.ask_input
      end
    end
  end

  describe '#get_pieces' do
    context 'a coordinates is inputted' do
      subject(:game) { described_class.new }

      it 'returns the corresponding piece' do
        expect(game.get_piece([0, 1])).to be_a Pawn
      end
    end
  end

  describe '#move_piece' do
    context 'we have a piece and coordinates' do
      subject(:game) { described_class.new }
      let(:piece) { Pawn.new([0, 1], 'W') }

      it 'should update the board' do
        game.move_piece(piece, [0, 2])
        expect(game.board.row(2)[0]).to be_a Pawn
        expect(game.board.row(1)[0]).to be_a EmptySquare
      end

      it 'should update the eated piece' do
        game.move_piece(piece, [7, 7])
        expect(game.black_eated).to eq(['R'])
      end

      it 'should return the updated piece' do
        expect(game.move_piece(piece, [4, 5])).to be_a Pawn
      end
    end
  end

  describe '#list_moves' do
    context 'player wants to move a piece' do
      subject(:game) { described_class.new }
      let(:bishop) { Bishop.new([3, 3], 'W') }

      it 'returns the actual possible moves' do
        moves = [[2, 2], [4, 2], [2, 4], [1, 5], [0, 6], [4, 4], [5, 5], [6, 6]]

        expect(game.list_moves(bishop)).to match_array(moves)
      end
    end
  end

  describe '#pawn_eat' do
    context 'the piece is a pawn' do
      subject(:game) { described_class.new }
      let(:piece) { Pawn.new([3, 5], 'W') }

      it 'returns the eat list' do
        eat = [[2, 6], [4, 6]]
        expect(game.pawn_eat(piece)).to match_array(eat)
      end
    end
  end

  describe '#pawn_moves' do
    context 'in front another piece' do
      subject(:game) { described_class.new }
      let(:piece) { Pawn.new([3, 5], 'W') }

      it 'returns an empty array' do
        expect(game.pawn_moves(piece)).to eq([])
      end
    end

    context 'it\'s the first move' do
      subject(:game) { described_class.new }
      let(:piece) { Pawn.new([0, 1], 'W') }

      it 'returns a list moves' do
        moves = [[0, 2], [0, 3]]
        expect(game.pawn_moves(piece)).to match_array(moves)
      end
    end

    context 'it\'s the first move and another piece is in the second square in front of the pawn' do
      subject(:game) { described_class.new }
      let(:pawn) { Pawn.new([4, 1], 'W') }

      before do
        game.board.row(3)[4] = King.new([4, 3], 'B')
      end

      it 'return only the first step' do
        moves = [[4, 2]]
        expect(game.pawn_moves(pawn)).to eq(moves)
      end
    end
  end

  describe '#check' do
    context 'a piece has been moved in the scope of the king' do
      subject(:game) { described_class.new }
      let(:king) { King.new([3, 3], 'B') }
      let(:knight) { Knight.new([1, 2], 'W') }

      before do
        game.board.row(3)[3] = king
      end

      xit 'display check message' do
        expect(game).to receive(:puts).with('Check!').once
        game.check(knight)
      end
    end
  end

  describe '#check_mate' do
    context 'the king is within the scope of the moved piece, we check if all the other king moves put him in check' do
      subject(:game) { described_class.new }
      let(:bishop) { Bishop.new([5, 1], 'B') }

      xit 'if so, game ends with the declaration of winner' do
        expect(game).to receive(:puts).with('Check')
        game.check_mate(bishop)
      end
    end
  end

  describe '#copy_board' do
    context 'the method is called with a piece king' do
      subject(:game) { described_class.new }
      let(:king_new) { King.new([3, 3], 'W') }
      let(:king_old) { King.new([4, 4], 'W') }
      let(:board_copy) { Board.new }

      before do
        board_copy.row(4)[4] = EmptySquare.new([4, 4])
        board_copy.row(3)[3] = King.new([3, 3], 'W')
      end

      xit 'update the copy of the board' do
        expect(game.copy_board(king_old, [3, 3]).row(3)[3].name).to eq('K')

        expect(game.copy_board(king_old, [3, 3]).row(4)[4].name).to eq('E')
      end
    end
  end

  describe '#check_king' do
    context 'the king is in scope of a piece, we create a copy of the board with all the updated position of the king and check if the king is in check in that position' do
      subject(:game) { described_class.new }
      let(:king) { King.new([3, 3], 'W') }
      let(:king_eat) { King.new([3, 3], 'B') }
      let(:board_copy) { Board.new }

      before do
        allow(game).to receive(:copy_board).and_return(board_copy)
      end

      it 'returns an empty array' do
        expect(game.check_king(king)).to eq([])
      end

      it 'returns the moves of the king with check' do
        expect(game.check_king(king_eat)).to eq([[2, 2], [3, 2], [4, 2]])
      end
    end
  end
end
