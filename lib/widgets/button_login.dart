import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {

  final VoidCallback _onPressed;
  ButtonLogin({Key key, VoidCallback onPressed}):
      _onPressed = onPressed,
      super(key:key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45.0,
      child: RaisedButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius : BorderRadius.circular(10)
        ),
        onPressed: _onPressed,
        child: Text('Login to your account', style: TextStyle(fontSize: 16, color: Colors.white),),
        ),
    );
  }
}