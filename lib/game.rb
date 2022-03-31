Dir['./lib/*.rb'].each { |file| require file }

class Game
  attr_reader :board, :white_eated, :black_eated

  def initialize
    @board = Board.new
    @player = 'W'
    @white_eated = []
    @black_eated = []
  end

  def play
    turn
    @player = @player == 'W' ? 'B' : 'W'
  end

  def check_mate(piece)
    foe = piece.player == 'W' ? 'B' : 'W'
    moves = piece.possible_moves.select do |move|
      @board.row(move.last)[move.first].name == 'K' && @board.row(move.last)[move.first].player == foe
    end
    puts 'Check' unless moves.empty?
  end

  def game_finished?
    return puts 'Player Black won!' if @white_eated.include?('K')

    return puts 'Player White won!' if @black_eated.include?('K')
  end

  def turn
    puts "It's #{@player} player turn"
    puts 'Choose a piece to move using coordinates'
    piece = get_piece(ask_input)
    return play unless piece.player == @player

    moves = piece.name == 'P' ? pawn(piece) : list_moves(piece)
    puts "Here's the possible moves for #{piece.name}"
    p moves
    puts 'Choose where to move the piece'
    goal_coordinates = ask_input
    return play unless moves.include?(goal_coordinates)

    move_piece(piece, goal_coordinates)
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
