import 'package:flutter/material.dart';

class Button2 extends StatelessWidget {
  String _txt = "";
  int _mode;
  int _value;
  Function _fn;

  Button2({String txt, int mode, int value, Function fn}) {
    this._txt = txt;
    this._mode = mode;
    this._value = value;
    this._fn = fn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: RaisedButton(
            padding: EdgeInsets.all(10),
            color: Colors.deepOrangeAccent,
            onPressed: () {
              _fn(_mode, _value);
            },
            child: Text(
              '$_txt',
              style: TextStyle(fontSize: 25),
            )));
  }
}
