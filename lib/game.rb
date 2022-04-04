require_relative 'rook'
require_relative 'knight'
require_relative 'empty_square'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'board'
require_relative 'serialization'

class Game
  attr_reader :board, :white_eated, :black_eated, :turn

  include Serialization

  def initialize
    @board = Board.new
    @player = 'W'
    @white_eated = []
    @black_eated = []
    @turn = 1
  end

  def play
    if @turn == 1
      puts 'Would you like to load the previous game? y/n'
      from_yaml if gets.chomp == 'y'
    end
    piece = turn
    check(piece)
    game_finished
    @player = @player == 'W' ? 'B' : 'W'
    @turn += 1
    @board.display
    puts 'Would you like to save the game and exit? y/n'
    return to_yaml if gets.chomp == 'y'

    play
  end

  def game_finished
    if @white_eated.include?('K') || @black_eated.include?('K')
      @board.display
      puts "#{@player} wins!"
      exit
    end
  end

  def check(piece)
    moves = moves_by_piece(piece)
    moves.each do |coordinate|
      other_piece = get_piece(coordinate)
      if other_piece.name == 'K' && other_piece.player != @player
        if check_mate(other_piece)
          @board.display
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
    check_king(piece).sort == moves.sort
  end

  def check_king(piece)
    moves = moves_by_piece(piece)
    moves_with_check = []
    moves.each do |coordinate|
      board_copy = copy_board
      board_copy.row(coordinate.last)[coordinate.first] = King.new(coordinate, piece.player)
      board_copy.row(piece.position.last)[piece.position.first] = EmptySquare.new(piece.position)
      board_copy.grid.each do |row|
        row.each do |piece_copy|
          next if piece_copy.is_a? EmptySquare

          moves_copy = moves_by_piece(piece_copy, board_copy)
          moves_with_check << coordinate if moves_copy.include?(coordinate) && piece_copy.player != piece.player
        end
      end
    end
    moves_with_check.uniq
  end

  def copy_board
    Marshal.load(Marshal.dump(@board))
  end

  def turn
    @board.display
    puts "It's #{@player} player turn"
    puts 'Choose a piece to move using coordinates'
    piece = get_piece(ask_input)
    return play unless piece.player == @player

    moves = moves_by_piece(piece)
    if moves.empty?
      puts 'You cannot move that piece!'
      return play
    end
    puts "Here's the possible moves for #{piece.name}"
    p moves
    puts 'Choose where to move the piece'
    goal_coordinates = ask_input
    return play unless moves.include?(goal_coordinates)

    move_piece(piece, goal_coordinates)
  end

  def moves_by_piece(piece, board = @board)
    piece.name == 'P' ? pawn(piece, board) : list_moves(piece, board)
  end

  def list_moves(piece, board = @board)
    actual_moves = []
    piece.possible_moves.each do |direction|
      direction.each do |coordinate|
        other_piece = get_piece(coordinate, board)
        actual_moves << coordinate unless other_piece.player == piece.player
        break unless other_piece.is_a? EmptySquare
      end
    end
    actual_moves
  end

  def pawn(piece, board = @board)
    moves = pawn_moves(piece, board)
    eat = pawn_eat(piece, board)
    moves.concat(eat)
  end

  def pawn_moves(piece, board = @board)
    actual_moves = []
    piece.possible_moves.each do |direction|
      direction.each do |coordinate|
        other_piece = get_piece(coordinate, board)
        actual_moves << coordinate if other_piece.is_a?(EmptySquare)
      end
    end
    actual_moves
  end

  def pawn_eat(piece, board = @board)
    eat = []
    piece.possible_eat.each do |direction|
      direction.each do |coordinate|
        piece_to_eat = get_piece(coordinate, board)
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

  def get_piece(coordinates, board = @board)
    x = coordinates.first
    y = coordinates.last
    board.row(y)[x]
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

game = Game.new
game.play
