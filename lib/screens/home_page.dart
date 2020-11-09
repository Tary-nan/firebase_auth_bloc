
import 'package:firebase_auth_bloc/blocs/authentication_bloc.dart';
import 'package:firebase_auth_bloc/events/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('home');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()=> BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventLoggOut()), 
          icon: Icon(Icons.exit_to_app),)
        ]
      ),
      body: Center(child: Text("Home page")),
    );
  }
}