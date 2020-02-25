import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  int _i;
  int _j;
  int _move;
  int _difficultyLevelMode;
  int _multiPlayer;
  bool _turn;
  Function _fn;
  String _buttonText = "";
  Function _checkWinner;
  Function _multiPlayerEngine;

  Button(
      {int i,
      int j,
      int difficultyLevelMode,
      bool turn,
      Function fn,
      String buttonText,
      Function checkWinner,
      Function multiPlayerEngine,
      int move,
      int multiPlayer}) {
    this._i = i;
    this._j = j;
    this._difficultyLevelMode = difficultyLevelMode;
    this._turn = turn;
    this._fn = fn;
    this._buttonText = buttonText;
    this._checkWinner = checkWinner;
    this._move = move;
    this._multiPlayer = multiPlayer;
    this._multiPlayerEngine = multiPlayerEngine;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        padding: EdgeInsets.all(20),
        elevation: 10,
        color: Colors.yellow,
        onPressed: () {
          if (_multiPlayer == 2) {
            ++_move;
            _fn(_turn, _i, _j);
            _checkWinner(_move);
          } else if (_multiPlayer == 1) {
            if (_difficultyLevelMode != 0) {
              print("just pressed and move is : $_move");
              ++_move;
              _fn(_turn, _i, _j);
              _checkWinner(_move);
              print("first checkwinner  call completed");
              print("user over and move is : $_move");

              if (_move < 9) {
                ++_move;
                _multiPlayerEngine();
                print("engine  call completed");
                _checkWinner(_move);
                print("second checkwinner call completed");
                print("engine over and move is : $_move");
              }
            }
          }
        },
        child: Text(
          _buttonText ?? "",
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
