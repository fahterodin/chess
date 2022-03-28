Dir['./lib/*.rb'].each { |file| require file }

class Game
  include Piece

  def initialize
    @board = Board.new
    @player = 'white'
  end

  def ask_input
    puts "It's #{@player} turn"
    puts 'Choose a piece to move using coordinates'
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
      puts 'Choose number between 0 and 7'
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
