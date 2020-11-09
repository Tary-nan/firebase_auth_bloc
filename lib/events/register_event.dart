import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// ********************************************************************
/// ********************************************************************
/// SIGN IN WITH
/// => EMAIL AND PASSWORD
///
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object> get props => [];
}


class RegisterEventEmailChanged  extends RegisterEvent{
  final String email;
  // constructor
  const RegisterEventEmailChanged({@required this.email});
  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'Email change : $email';
  }
}
class RegisterEventPasswordChanged  extends RegisterEvent{
  final String password;
  // constructor
  const RegisterEventPasswordChanged({@required this.password});
  @override
  List<Object> get props => [password];

  @override
  String toString() {
    return 'Password changed : $password';
  }
}

  /// ********************************************************************
  /// ********************************************************************
  /// EVENT FOR Register GOOGLE
  /// => EMAIL AND PASSWORD
  ///


class RegisterEventPressed extends RegisterEvent{

  final String email;
  final String password;
  const RegisterEventPressed(
    {
      @required this.email, 
      @required this.password
    });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return ' RegisterEventWithEmailPasswordPressed : Email : $email, Password : $password';
  }
}
