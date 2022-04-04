Dir["./lib/*.rb"].each {|file| require file }

game = Game.new
game.start
