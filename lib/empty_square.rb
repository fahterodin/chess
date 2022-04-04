class EmptySquare
  attr_reader :position, :player, :name, :display

  def initialize(position)
    @position = position
    @player = 'E'
    @name = 'E'
    @display = ' '
  end
end
