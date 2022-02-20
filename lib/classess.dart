class Game {
  static void playGame({
    required index,
    required activePlayer,
  }) {}

  void checkWinner(){}
  void autoPlay(){}
}
class Player {
 static const String x = 'x' ;
 static const String o =  'o' ;
 static const String empty =  '' ;
  List<int> playerX = [] ;
  List<int> playerO = [] ;
}
