import 'package:firebase_auth_bloc/blocs/authentication_bloc.dart';
import 'package:firebase_auth_bloc/blocs/login_bloc.dart';
import 'package:firebase_auth_bloc/events/authentication_event.dart';
import 'package:firebase_auth_bloc/events/login_event.dart';
import 'package:firebase_auth_bloc/repositories/user_repository.dart';
import 'package:firebase_auth_bloc/states/login_state.dart';
import 'package:firebase_auth_bloc/widgets/button_login.dart';
import 'package:firebase_auth_bloc/widgets/button_user_register.dart';
import 'package:firebase_auth_bloc/widgets/buuton_google_login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {

  final UserRepository _userRepository;
  // constructor
  LoginScreen({Key key, @required UserRepository userRepository}):
    assert(userRepository != null),
    _userRepository = userRepository,
    super(key:key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(() {
      print(_emailController.text);
      // ecoute les changement de valeur aux sein de champs email
      _loginBloc.add(LoginEventEmailChanged(
      email: _emailController.text,
    ));
      
    });
  _passwordController.addListener(() {
    print(_passwordController.text);
     // ecoute les changement de valeur aux sein de champs password
     _loginBloc.add(LoginEventPasswordChanged(
      password: _passwordController.text
    ));
    
  });
  }

  bool get isNotEmpti  => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isLoginButtonEnabled(LoginState loginState)=> 
        loginState.isValidEmailAndiPassword & isNotEmpti && !loginState.isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, loginState){
          if(loginState.isFailure){
            print('is failure');
          }else if(loginState.isSubmitting){
            print('is submitting');
          }else if(loginState.isSuccess){
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
                    validator: (_)=> loginState.isValidEmail ? null :'Email Incorrect',
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
                    validator: (_)=> loginState.isValidPassword ? null : 'invalid Password format',
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(Icons.lock)
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonLogin(
                        onPressed: 
                        isLoginButtonEnabled(loginState)
                        ? _onLoginEmailAndPassword
                        : null,
                    ),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  ButtonUserRegister(userRepository: _userRepository),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  ButtonGoogleLogin()
                    ]
                  )
                ]
              ),
            ),
          );
        }),
    );
  }

  void _onLoginEmailAndPassword(){
    _loginBloc.add(LoginEventWithEmailPasswordPressed(
      email: _emailController.text,
      password: _passwordController.text
    ));
  }
}