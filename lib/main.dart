import 'package:firebase_auth_bloc/blocs/authentication_bloc.dart';
import 'package:firebase_auth_bloc/blocs/login_bloc.dart';
import 'package:firebase_auth_bloc/blocs/simple_bloc_observer.dart';
import 'package:firebase_auth_bloc/couterBloc/main.dart';
import 'package:firebase_auth_bloc/events/authentication_event.dart';
import 'package:firebase_auth_bloc/repositories/user_repository.dart';
import 'package:firebase_auth_bloc/screens/home_page.dart';
import 'package:firebase_auth_bloc/screens/login_screen.dart'; 
import 'package:firebase_auth_bloc/screens/place.dart';
import 'package:firebase_auth_bloc/screens/splash_screen.dart';
import 'package:firebase_auth_bloc/states/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(CounterBlocPaga());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  UserRepository _userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Login with Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),  
      //home: RoutesWidget(),
      home: BlocProvider(
        create: (BuildContext context)  => AuthenticationBloc(userRepository: _userRepository)..add(AuthenticationEventStarted()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authentication) {
                if(authentication is AuthenticationStateSuccess){
                  return HomeScreen();// HomePga
                }else if(authentication is AuthenticationStateFailed){
                  return BlocProvider<LoginBloc>(
                    create: (context)=> LoginBloc(userRepository: _userRepository),
                    child: LoginScreen(userRepository: _userRepository,));
                }
                return SplashScreen();
              }
            )
        ),
      debugShowCheckedModeBanner: false,
    );
  }
}