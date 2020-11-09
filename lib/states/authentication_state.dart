import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable{
  const AuthenticationState();
  @override
  // ignore: todo
  //TODO: implement props
  List<Object> get props => [];
}

class AuthenticationStateInitial extends AuthenticationState {}
class AuthenticationStateSuccess extends AuthenticationState {
  final FirebaseUser firebaseUser;
  const AuthenticationStateSuccess({this.firebaseUser});

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return "AuthenticationStateSuccess : ${firebaseUser.email}" ;
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [firebaseUser];
}

class AuthenticationStateFailed extends AuthenticationState {} 