require_relative 'rook'
require_relative 'knight'
require_relative 'empty_square'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'board'

class Game
  attr_reader :board, :white_eated, :black_eated

  def initialize
    @board = Board.new
    @player = 'W'
    @white_eated = []
    @black_eated = []
  end

  def play
    piece = turn
    check(piece)
    @player = @player == 'W' ? 'B' : 'W'
    play
  end

  def check(piece)
    moves = moves_by_piece(piece)
    moves.each do |coordinate|
      other_piece = get_piece(coordinate)
      if other_piece.name == 'K' && other_piece.player != @player
        if check_mate(other_piece)
          puts "Check mate: #{@player} player win!"
          exit
        end
        puts 'Check!'
        break
      end
    end
  end

  def check_mate(piece)
    moves = moves_by_piece(piece)
    check_king(piece, moves).sort == moves.sort
  end

  def check_king(piece, moves)
    moves_with_check = []
    moves.each do |coordinate|
      board_copy = copy_board(piece, coordinate)
      for i in 0..7 do
        for j in 0..7 do
          piece_copy = board_copy.row(i)[j]
          next if piece_copy.is_a? EmptySquare

          moves_copy = moves_by_piece(piece_copy)
          moves_with_check << piece.position if moves_copy.include?(coordinate)
        end
      end
    end
    moves_with_check
  end

  def copy_board(piece, coordinate)
    board_copy = Marshal.load(Marshal.dump(@board))
    old_position = piece.position
    board_copy.row(coordinate.last)[coordinate.first] = King.new(coordinate, piece.player)
    board_copy.row(old_position.last)[old_position.first] = EmptySquare.new(old_position)
    board_copy
  end

  def turn
    @board.display
    puts "It's #{@player} player turn"
    puts 'Choose a piece to move using coordinates'
    piece = get_piece(ask_input)
    return play unless piece.player == @player

    moves = moves_by_piece(piece)
    puts "Here's the possible moves for #{piece.name}"
    p moves
    puts 'Choose where to move the piece'
    goal_coordinates = ask_input
    return play unless moves.include?(goal_coordinates)

    move_piece(piece, goal_coordinates)
  end

  def moves_by_piece(piece)
    piece.name == 'P' ? pawn(piece) : list_moves(piece)
  end

  def list_moves(piece)
    actual_moves = []
    piece.possible_moves.each do |direction|
      direction.each do |coordinate|
        other_piece = get_piece(coordinate)
        actual_moves << coordinate unless other_piece.player == piece.player
        break unless other_piece.is_a? EmptySquare
      end
    end
    actual_moves
  end

  def pawn(piece)
    moves = pawn_moves(piece)
    eat = pawn_eat(piece)
    moves.concat(eat)
  end

  def pawn_moves(piece)
    actual_moves = []
    piece.possible_moves.each do |direction|
      direction.each do |coordinate|
        other_piece = get_piece(coordinate)
        actual_moves << coordinate if other_piece.is_a?(EmptySquare)
      end
    end
    actual_moves
  end

  def pawn_eat(piece)
    eat = []
    piece.possible_eat.each do |direction|
      direction.each do |coordinate|
        piece_to_eat = get_piece(coordinate)
        eat << coordinate unless piece_to_eat.is_a?(EmptySquare) || piece_to_eat.player == @player
      end
    end
    eat
  end

  def move_piece(piece, goal)
    goal_piece = get_piece(goal)
    if @player == 'W'
      @black_eated << goal_piece.name unless goal_piece.is_a? EmptySquare
    else
      @white_eated << goal_piece.name unless goal_piece.is_a? EmptySquare
    end
    old_position = piece.position
    piece.update_position(goal)
    @board.row(goal.last)[goal.first] = piece
    @board.row(old_position.last)[old_position.first] = EmptySquare.new(old_position)
    piece
  end

  def get_piece(coordinates)
    x = coordinates.first
    y = coordinates.last
    @board.row(y)[x]
  end

  def ask_input
    puts 'Choose x coordinate'
    x = gets.chomp
    x = convert_to_i(x)
    puts 'Choose y coordinate'
    y = gets.chomp
    y = convert_to_i(y)
    if x.nil? || y.nil?
      puts 'Wrong input!'
      return
    end
    if x.negative? || x > 7 || y.negative? || y > 7
      puts 'Choose numbers between 0 and 7'
      return
    end
    [x, y]
  end

  private

  def convert_to_i(str)
    begin
      Integer(str)
    rescue ArgumentError
      nil
    end
  end
end

# game = Game.new
# game.play
