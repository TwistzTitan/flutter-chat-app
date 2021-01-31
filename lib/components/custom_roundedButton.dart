import 'package:flutter/material.dart';

class CustomRoundedButtton extends StatelessWidget {

  Color _color; 
  String _titleText;
  Function _funcPressed; 

  CustomRoundedButtton({Color color = Colors.orange, @required String title, Function press}){
    assert(title.isNotEmpty,true);
    this._titleText = title;
    this._color = color;
    this._funcPressed = press;
  }

  get wColor => _color;
  get wText => _titleText;
  get wFunction => _funcPressed;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: wColor,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: wFunction,
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                   wText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
  }
}