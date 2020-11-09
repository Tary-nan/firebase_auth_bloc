import 'package:firebase_auth_bloc/blocs/register_bloc.dart';
import 'package:firebase_auth_bloc/repositories/user_repository.dart';
import 'package:firebase_auth_bloc/screens/register_screen.dart';
// import 'package:firebase_auth_bloc/widgets/button_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sprinkle/SprinkleExtension.dart';

class ButtonUserRegister extends StatelessWidget {
  final UserRepository _userRepository;

  ButtonUserRegister({Key key, UserRepository userRepository}):
      _userRepository = userRepository,
      super(key:key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45.0,
      child: RaisedButton(
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius : BorderRadius.circular(10)
        ),
        onPressed: (){
          // context.display(
          //   BlocProvider<RegisterBloc>(
          //     create: (context)=> RegisterBloc(userRepository: _userRepository,),
          //     child: RegisterScreen(userRepository: _userRepository,)));
        },
        child: Text('Register a new account', style: TextStyle(fontSize: 16, color: Colors.white),),
        ),
    );
  }
}