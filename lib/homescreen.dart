import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xogame/classess.dart';
import 'package:xogame/methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool withFriend = false;
bool changePlayer = false;
bool gameOver = false;
Player player = Player();
String? winner;
String? equal;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            MyHeightSizedBox(x: 20),
            SwitchListTile.adaptive(
              title: MyText(
                text: 'Play with friend ?',
                fontSize: 28,
                color: Colors.white,
              ),
              value: withFriend,
              onChanged: (value) {
                setState(() {
                  withFriend = value;
                });
              },
              activeColor: Colors.deepPurple,
              inactiveThumbColor: Colors.white,
            ),
            MyHeightSizedBox(x: 20),
            MyText(
              text: changePlayer
                  ? 'Turn on [ O ] Player '.toUpperCase()
                  : 'Turn on [ X ] Player '.toUpperCase(),
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
            MyHeightSizedBox(x: 50),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                children: List.generate(
                  9,
                  (index) => InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: gameOver
                        ? null
                        : () {
                            if (player.playerX.contains(index) == false &&
                                player.playerO.contains(index) == false) {
                              if (withFriend) {
                                playFriend(index);
                              }

                              if (!withFriend) {
                                playComputer(index);
                              }
                              setState(() {
                                print(changePlayer);
                                changePlayer = !changePlayer;
                              });
                              if (!withFriend &&gameOver==false ) {
                                     computerTurn();
                              }
                              setState(() {
                                print(changePlayer);
                                changePlayer = !changePlayer;
                              });
                              winnerPlayer();

                              if (player.playerX.length == 5) {
                                setState(() {
                                  gameOver = true;
                                });
                              }
                            }
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 200,
                      height: 200,
                      child: Center(
                        child: MyText(
                          text: player.playerX.contains(index)
                              ? 'x'
                              : player.playerO.contains(index)
                                  ? 'o'
                                  : '',
                          fontSize: 80,
                          color: player.playerX.contains(index)
                              ? Colors.blueAccent
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (winner != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(text: 'The', fontSize: 30),
                  MyText(
                    text: ' $winner',
                    fontSize: 30,
                    color: winner == 'X' ? Colors.blueAccent : Colors.red,
                  ),
                  MyText(text: ' player is winner', fontSize: 30),
                ],
              ),
            if (gameOver == true && winner == null)
              MyText(
                text: ' The Two players is equal',
                fontSize: 30,
              ),
            MyHeightSizedBox(
              x: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: MyElevetedButton(
                color: Colors.white,
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.replay,
                      color: Colors.deepPurple,
                    ),
                    MyText(
                      text: 'Replay',
                      fontSize: 20,
                      color: Colors.deepPurple,
                    ),
                  ],
                ),
                function: () {
                  setState(() {
                    player.playerO = [];
                    player.playerX = [];
                    changePlayer = false;
                    gameOver = false;
                    winner = null;
                    equal = null;
                  });
                },
              ),
            ),
            MyHeightSizedBox(
              x: 50,
            ),
          ],
        ),
      ),
    );
  }

  void playFriend(int index) {
    if (changePlayer == false) {
      player.playerX.add(index);
    }
    if (changePlayer == true) {
      player.playerO.add(index);
    }
  }

   playComputer(int index)  {
    if (changePlayer == false) {
      player.playerX.add(index);
    }
  }

  void computerTurn() {
    List emptyCells = [];
    var random = Random();
    if (withFriend == false) {
      if (changePlayer == true) {
        for (int i = 0; i < 9; i++) {
          if (player.playerX.contains(i) == false &&
              player.playerO.contains(i) == false) {
            emptyCells.add(i);
          }
        }
        // print(emptyCells.length.toString() + 'lenght');
        int num = random.nextInt(emptyCells.length);
        int randomIndex = emptyCells[num];
        player.playerO.add(randomIndex);
      }
    }
  }

  winnerPlayer() {
    if (player.playerX.contains(0) &&
        player.playerX.contains(1) &&
        player.playerX.contains(2)) {
      setState(() {
        winner = 'X';
        gameOver = true;
      });
    }
    if (player.playerX.contains(0) &&
        player.playerX.contains(3) &&
        player.playerX.contains(6)) {
      setState(() {
        winner = 'X';
        gameOver = true;
      });
    }
    if (player.playerX.contains(0) &&
        player.playerX.contains(4) &&
        player.playerX.contains(8)) {
      setState(() {
        winner = 'X';
        gameOver = true;
      });
    }
    if (player.playerX.contains(1) &&
        player.playerX.contains(4) &&
        player.playerX.contains(7)) {
      setState(() {
        winner = 'X';
        gameOver = true;
      });
    }
    if (player.playerX.contains(2) &&
        player.playerX.contains(5) &&
        player.playerX.contains(8)) {
      setState(() {
        winner = 'X';
        gameOver = true;
      });
    }
    if (player.playerX.contains(3) &&
        player.playerX.contains(4) &&
        player.playerX.contains(5)) {
      setState(() {
        winner = 'X';
        gameOver = true;
      });
    }
    if (player.playerX.contains(6) &&
        player.playerX.contains(7) &&
        player.playerX.contains(8)) {
      setState(() {
        winner = 'X';
        gameOver = true;
      });
    }
    if (player.playerX.contains(2) &&
        player.playerX.contains(4) &&
        player.playerX.contains(6)) {
      setState(() {
        winner = 'X';
        gameOver = true;
      });
    }
    /////////////////////////////////////////
    if (player.playerO.contains(0) &&
        player.playerO.contains(1) &&
        player.playerO.contains(2)) {
      setState(() {
        winner = 'O';
        gameOver = true;
      });
    }
    if (player.playerO.contains(0) &&
        player.playerO.contains(3) &&
        player.playerO.contains(6)) {
      setState(() {
        winner = 'O';
        gameOver = true;
      });
    }
    if (player.playerO.contains(0) &&
        player.playerO.contains(4) &&
        player.playerO.contains(8)) {
      setState(() {
        winner = 'O';
        gameOver = true;
      });
    }
    if (player.playerO.contains(1) &&
        player.playerO.contains(4) &&
        player.playerO.contains(7)) {
      setState(() {
        winner = 'O';
        gameOver = true;
      });
    }
    if (player.playerO.contains(2) &&
        player.playerO.contains(5) &&
        player.playerO.contains(8)) {
      setState(() {
        winner = 'O';
        gameOver = true;
      });
    }
    if (player.playerO.contains(3) &&
        player.playerO.contains(4) &&
        player.playerO.contains(5)) {
      setState(() {
        winner = 'O';
        gameOver = true;
      });
    }
    if (player.playerO.contains(6) &&
        player.playerO.contains(7) &&
        player.playerO.contains(8)) {
      setState(() {
        winner = 'O';
        gameOver = true;
      });
    }
    if (player.playerO.contains(2) &&
        player.playerO.contains(4) &&
        player.playerO.contains(6)) {
      setState(() {
        winner = 'O';
        gameOver = true;
      });
    }
  }

  equalGame() {
    if (winner == null) {
      setState(() {
        equal = 'Equal';
      });
    }
  }
}
