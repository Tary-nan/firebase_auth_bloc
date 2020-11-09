import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// ********************************************************************
/// ********************************************************************
/// SIGN IN WITH
/// => EMAIL AND PASSWORD
///
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}


class LoginEventEmailChanged  extends LoginEvent{
  final String email;
  // constructor
  const LoginEventEmailChanged({@required this.email});
  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'Email change : $email';
  }
}
class LoginEventPasswordChanged  extends LoginEvent{
  final String password;
  // constructor
  const LoginEventPasswordChanged({@required this.password});
  @override
  List<Object> get props => [password];

  @override
  String toString() {
    return 'Password changed : $password';
  }
}

  /// ********************************************************************
  /// ********************************************************************
  /// EVENT FOR LOGIN GOOGLE
  /// => EMAIL AND PASSWORD
  ///


class LoginEventWithGooglePressed extends LoginEvent{}
class LoginEventWithEmailPasswordPressed extends LoginEvent{

  final String email;
  final String password;
  const LoginEventWithEmailPasswordPressed(
    {
      @required this.email, 
      @required this.password
    });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return ' LoginEventWithEmailPasswordPressed : Email : $email, Password : $password';
  }
}
