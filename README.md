GENERAL DIRECTION

1. Build a command line Chess game where two player can play against each other

2. Possibility to save and load the game at every turn (serialization)

3. Be careful for legal moves, declare check and check mate

4. TDD the important parts

5. Methods should be doing one thing each

WHERE TO START

1. There should be a Board class where all the pieces will move.

2. There should be a Piece general class with general pieces methods (ex: legal moves)

3. There should be a Serialization module for the Board class, that save and load the game

4. Every piece should have a class with the specific methods for that piece. Pieces are: 1 king, 1 queen, 2 rooks, 2 bishops, 2 knights and 8 pawns

5. Finally the Game class that actually implement all the other class, taking turn, asking the player what piece he want to move, giving him all the possible moves that piece can do, removing the piece that get eaten, checking for declared check and checkmate

PSEUDOCODE

Board class, it's a grid of 8x8 squares.
The grid is an array of 8 elements each of them is an array of 8 elements.
It should have a method for displaying the board
