import 'package:firebase_auth_bloc/blocs/authentication_bloc.dart';
import 'package:firebase_auth_bloc/blocs/login_bloc.dart';
import 'package:firebase_auth_bloc/blocs/register_bloc.dart';
import 'package:firebase_auth_bloc/events/authentication_event.dart';
import 'package:firebase_auth_bloc/events/login_event.dart';
import 'package:firebase_auth_bloc/events/register_event.dart';
import 'package:firebase_auth_bloc/repositories/user_repository.dart';
import 'package:firebase_auth_bloc/states/login_state.dart';
import 'package:firebase_auth_bloc/states/registration_state.dart';
import 'package:firebase_auth_bloc/widgets/button_login.dart';
import 'package:firebase_auth_bloc/widgets/button_register.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {

  final UserRepository _userRepository;
  // constructor
  RegisterScreen({Key key, @required UserRepository userRepository}):
    assert(userRepository != null),
    _userRepository = userRepository,
    super(key:key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegisterBloc _registerBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  //   _emailController.addListener(() {
  //     print(_emailController.text);
  //     // ecoute les changement de valeur aux sein de champs email
  //     _registerBloc.add(RegisterEventEmailChanged(
  //     email: _emailController.text,
  //   ));
      
  //   });
  // _passwordController.addListener(() {
  //   print(_passwordController.text);
  //    // ecoute les changement de valeur aux sein de champs password
  //    _registerBloc.add(RegisterEventPasswordChanged(
  //     password: _passwordController.text
  //   ));
    
  // });
  }

  bool get isNotEmpti  => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isRegisterButtonEnabled(RegisterState registerState)=> 
        registerState.isValidEmailAndiPassword && isNotEmpti && !registerState.isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, registerState){
          if(registerState.isFailure){
            print('is failure');
          }else if(registerState.isSubmitting){
            print('is submitting');
          }else if(registerState.isSuccess){
            print('is success');
            BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventLoggedIn());
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: ListView( 
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_)=> registerState.isValidEmail ? null :'Email Incorrect',
                    decoration: InputDecoration(
                      hintText: "Email",
                      icon: Icon(Icons.email)
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    // keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_)=> registerState.isValidPassword ? null : 'invalid Password format',
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(Icons.lock)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ButtonRegister(
                      onPressed: (){
                        if(isRegisterButtonEnabled(registerState)){
                              _registerBloc.add(RegisterEventPressed(
                              email: _emailController.text,
                              password: _passwordController.text
                            ));
                        }
                      }
                    ),
                  ),
                ]
              ),
            ),
          );
        }),
    );
  }
}