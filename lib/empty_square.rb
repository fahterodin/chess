class EmptySquare
  attr_reader :position, :player, :name

  def initialize(position)
    @position = position
    @player = 'E'
    @name = 'E'
  end
end
