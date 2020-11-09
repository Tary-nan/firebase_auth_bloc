import 'package:firebase_auth_bloc/blocs/login_bloc.dart';
import 'package:firebase_auth_bloc/events/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonGoogleLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45.0,
      child: RaisedButton.icon(
        icon: Icon(FontAwesomeIcons.google, color: Colors.white, size: 17,),
        color: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius : BorderRadius.circular(10)
        ),
        onPressed: ()=> BlocProvider.of<LoginBloc>(context).add(LoginEventWithGooglePressed()),
        label: Text('sign in with google', style: TextStyle(fontSize: 16, color: Colors.white),),
        ),
    );
  }
}