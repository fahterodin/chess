require 'yaml'

module Serialization
  def to_yaml
    f = File.open('save.yml', 'w')
    YAML.dump({
                board: @board,
                player: @player,
                white_eated: @white_eated,
                black_eated: @black_eated
              }, f)
    f.close
  end

  def from_yaml
    data = YAML.load(File.read('save.yml'))
    @board = data[:board]
    @player = data[:player]
    @white_eated = data[:white_eated]
    @black_eated = data[:black_eated]
  end
end
