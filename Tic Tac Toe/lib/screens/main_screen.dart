import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/button.dart';
import './widgets/button2.dart';
import './widgets/TextBox.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _move = 0;
  String _msg = "";
  bool _turn = true; //true for X and false for 0
  var _rng = new Random();
  int _temp1;
  int _temp2;
  int _multiPlayer = 0; //1 for single player and 2 for multi player
  int _gameMode = 0;
  int _difficultyLevel = 0; //
  int _difficultyLevelMode = 0;
  List<List<String>> mat = [
    [null, null, null],
    [null, null, null],
    [null, null, null]
  ];

  _print(bool turn, int i, int j) {
    print("inside print");
    if (turn == true) {
      if (mat[i][j] == null) {
        mat[i][j] = 'X';
        this._turn = false;
      }
    } else if (turn == false) {
      if (mat[i][j] == null) {
        mat[i][j] = '0';
        this._turn = true;
      }
    }
  }

  _checkWinner([int move = 0]) {
    print("inside check winner");
    this._move = move;
    print("value of move in check winner: $_move");

    if (move >= 5 && this._msg == "") {
      print("checking winner");

      // for rows
      for (int i = 0; i < 3; i++) {
        if (mat[i][0] != null) {
          if (mat[i][0] == mat[i][1] && mat[i][0] == mat[i][2]) {
            _msg = '${mat[i][0]} IS THE WINNER !!!';
            break;
          }
        }
      }

      // for columns
      for (int j = 0; j < 3; j++) {
        if (mat[0][j] != null) {
          if (mat[0][j] == mat[1][j] && mat[0][j] == mat[2][j]) {
            _msg = '${mat[0][j]} IS THE WINNER !!!';
            break;
          }
        }
      }

      // for 1 diagonal
      if (mat[0][0] == mat[1][1] &&
          mat[0][0] == mat[2][2] &&
          mat[0][0] != null) {
        _msg = '${mat[0][0]} IS THE WINNER !!!';
      }

      //for 2 diagonal
      if (mat[2][0] == mat[1][1] &&
          mat[2][0] == mat[0][2] &&
          mat[2][0] != null) {
        _msg = '${mat[2][0]} IS THE WINNER !!!';
      }

      if (move == 9 && _msg == "") {
        _msg = 'DRAW!!!';
      }
    }
    setState(() {});
  }

  _multiPlayerEngine() {
    bool run = true;
    bool dummy = false;

    outer:
    do {
      print("engine started and run is : $run ");

      int a = _rng.nextInt(10);

      if (a < _difficultyLevel) {
        if (run) {
          print("inside engine's first if");
//

          for (int i = 0; i < 3; i++) {
            if (mat[i][0] == mat[i][1] &&
                mat[i][0] != null &&
                mat[i][2] == null) {
              mat[i][2] = '0';
              this._turn = true;
              run = false;
              break outer;
            } else if (mat[i][0] == mat[i][2] &&
                mat[i][0] != null &&
                mat[i][1] == null) {
              mat[i][1] = '0';
              this._turn = true;
              run = false;
              break outer;
            } else if (mat[i][2] == mat[i][1] &&
                mat[i][2] != null &&
                mat[i][0] == null) {
              mat[i][0] = '0';
              run = false;
              this._turn = true;
              break outer;
            }
          } //end of for loop

          for (int i = 0; i < 3; i++) {
            if (mat[0][i] == mat[1][i] &&
                mat[0][i] != null &&
                mat[2][i] == null) {
              mat[2][i] = '0';
              this._turn = true;
              run = false;
              break outer;
            } else if (mat[1][i] == mat[2][i] &&
                mat[1][i] != null &&
                mat[0][i] == null) {
              mat[0][i] = '0';
              this._turn = true;
              run = false;
              break outer;
            } else if (mat[0][i] == mat[2][i] &&
                mat[0][i] != null &&
                mat[1][i] == null) {
              mat[1][i] = '0';
              this._turn = true;
              run = false;
              break outer;
            }
          }

          //main diag start
          if (mat[0][0] == mat[1][1] &&
              mat[1][1] != null &&
              mat[2][2] == null) {
            mat[2][2] = '0';
            this._turn = true;
            run = false;
          } else if (mat[1][1] == mat[2][2] &&
              mat[1][1] != null &&
              mat[0][0] == null) {
            mat[0][0] = '0';
            this._turn = true;
            run = false;
          } else if (mat[0][0] == mat[2][2] &&
              mat[0][0] != null &&
              mat[1][1] == null) {
            mat[1][1] = '0';
            this._turn = true;
            run = false;
          }
          //main diag finish

          //sec diag start
          else if (mat[0][2] == mat[1][1] &&
              mat[1][1] != null &&
              mat[2][0] == null) {
            mat[2][0] = '0';
            this._turn = true;
            run = false;
          } else if (mat[1][1] == mat[2][0] &&
              mat[1][1] != null &&
              mat[0][2] == null) {
            mat[0][2] = '0';
            this._turn = true;
            run = false;
          } else if (mat[0][2] == mat[2][0] &&
              mat[0][2] != null &&
              mat[1][1] == null) {
            mat[1][1] = '0';
            this._turn = true;
            run = false;
          }
          //sec diag finsh

          print("end of first if and run is : $run");
        }
      }
    } while (dummy == true);
    if (run) {
      print("inside engine's second if");
      _generateIndex();
      this._turn = true;
    }

    setState(() {
      run = true;
      print("inside engine's setstate");
    });
  }

  _generateIndex() {
    print("inside generateindex");
    _temp1 = _rng.nextInt(3);
    _temp2 = _rng.nextInt(3);
    if (mat[_temp1][_temp2] == null) {
      print("inside generateindex if");
      mat[_temp1][_temp2] = '0';
    } else {
      print("inside generateindex else");
      _generateIndex();
    }
  }

  _setGameMode(int mode, int value) {
    if (this._gameMode == 0) {
      this._gameMode = mode;
      _multiPlayer = value;
      setState(() {});
    }
  }

  _setDifficultyLevel(int mode, int value) {
    if (this._difficultyLevelMode == 0) {
      this._difficultyLevelMode = mode;
      _difficultyLevel = value;
      setState(() {});
    }
  }

  _reset() {
    _move = 0;
    _msg = "";
    _turn = true;
    _multiPlayer = 0;
    _difficultyLevelMode = 0;
    _gameMode = 0;
    mat = [
      [null, null, null],
      [null, null, null],
      [null, null, null]
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe '),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment:CrossAxisAlignment.center ,
              children: <Widget>[
                Button(
                    i: 0,
                    j: 0,
                    turn: _turn,
                    fn: _print,
                    buttonText: mat[0][0],
                    checkWinner: _checkWinner,
                    move: _move,
                    multiPlayer: _multiPlayer,
                    multiPlayerEngine: _multiPlayerEngine,
                    difficultyLevelMode: _difficultyLevelMode),
                Button(
                    i: 0,
                    j: 1,
                    turn: _turn,
                    fn: _print,
                    buttonText: mat[0][1],
                    checkWinner: _checkWinner,
                    move: _move,
                    multiPlayer: _multiPlayer,
                    multiPlayerEngine: _multiPlayerEngine,
                    difficultyLevelMode: _difficultyLevelMode),
                Button(
                    i: 0,
                    j: 2,
                    turn: _turn,
                    fn: _print,
                    buttonText: mat[0][2],
                    checkWinner: _checkWinner,
                    move: _move,
                    multiPlayer: _multiPlayer,
                    multiPlayerEngine: _multiPlayerEngine,
                    difficultyLevelMode: _difficultyLevelMode)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment:CrossAxisAlignment.center,
              children: <Widget>[
                Button(
                    i: 1,
                    j: 0,
                    turn: _turn,
                    fn: _print,
                    buttonText: mat[1][0],
                    checkWinner: _checkWinner,
                    move: _move,
                    multiPlayer: _multiPlayer,
                    multiPlayerEngine: _multiPlayerEngine,
                    difficultyLevelMode: _difficultyLevelMode),
                Button(
                    i: 1,
                    j: 1,
                    turn: _turn,
                    fn: _print,
                    buttonText: mat[1][1],
                    checkWinner: _checkWinner,
                    move: _move,
                    multiPlayer: _multiPlayer,
                    multiPlayerEngine: _multiPlayerEngine,
                    difficultyLevelMode: _difficultyLevelMode),
                Button(
                    i: 1,
                    j: 2,
                    turn: _turn,
                    fn: _print,
                    buttonText: mat[1][2],
                    checkWinner: _checkWinner,
                    move: _move,
                    multiPlayer: _multiPlayer,
                    multiPlayerEngine: _multiPlayerEngine,
                    difficultyLevelMode: _difficultyLevelMode)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment:CrossAxisAlignment.center,
              children: <Widget>[
                Button(
                    i: 2,
                    j: 0,
                    turn: _turn,
                    fn: _print,
                    buttonText: mat[2][0],
                    checkWinner: _checkWinner,
                    move: _move,
                    multiPlayer: _multiPlayer,
                    multiPlayerEngine: _multiPlayerEngine,
                    difficultyLevelMode: _difficultyLevelMode),
                Button(
                    i: 2,
                    j: 1,
                    turn: _turn,
                    fn: _print,
                    buttonText: mat[2][1],
                    checkWinner: _checkWinner,
                    move: _move,
                    multiPlayer: _multiPlayer,
                    multiPlayerEngine: _multiPlayerEngine,
                    difficultyLevelMode: _difficultyLevelMode),
                Button(
                    i: 2,
                    j: 2,
                    turn: _turn,
                    fn: _print,
                    buttonText: mat[2][2],
                    checkWinner: _checkWinner,
                    move: _move,
                    multiPlayer: _multiPlayer,
                    multiPlayerEngine: _multiPlayerEngine,
                    difficultyLevelMode: _difficultyLevelMode)
              ],
            ),
            TextBox(_msg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Button2(
                    fn: _setGameMode, mode: 1, txt: 'Single Player', value: 1),
                Button2(
                    fn: _setGameMode, mode: 1, txt: 'Multi Player', value: 2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Button2(
                    fn: _setDifficultyLevel, mode: 1, txt: 'Easy', value: 4),
                Button2(
                    fn: _setDifficultyLevel, mode: 1, txt: 'Medium', value: 7),
                Button2(
                    fn: _setDifficultyLevel, mode: 1, txt: 'Hard', value: 10),
              ],
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    padding: EdgeInsets.all(10),
                    color: Colors.deepOrangeAccent,
                    onPressed: () {
                      _reset();
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 32),
                    )))
          ],
        ),
      ),
    );
  }
}
