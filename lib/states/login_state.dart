import 'package:flutter/material.dart';

/// Une classe est immuable si tous les champs d'instance de la classe, ne chande pas
/// définis directement ou hérités, sont "définitifs".
@immutable
class LoginState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isValidEmailAndiPassword => isValidEmail && isValidPassword;

  ///
  /// CONSTRUCTOR
  ///
  LoginState({
    @required this.isValidEmail,
    @required this.isValidPassword,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });
  // chaque etat un object
  // peut etre cree en utilisant factory

  ///
  /// DIFFERENT STATE
  /// chaque etat un object
  /// peeut etre cree en utilisant factory
  ///
  /// CONSTRUCTOR INTIAL
  factory LoginState.initial()=> LoginState(
    isValidEmail : true,
    isValidPassword : true,
    isSubmitting : false,
    isSuccess : false,
    isFailure : false,
  );

  ///
  /// CONSTRUCTOR LOADING
  ///
  factory LoginState.loading()=> LoginState(
    isValidEmail : true,
    isValidPassword : true,
    isSubmitting : true,
    isSuccess : false,
    isFailure : false,
  );

  ///
  /// CONSTRUCTOR LOADING
  ///
  factory LoginState.failure()=> LoginState(
    isValidEmail : true,
    isValidPassword : true,
    isSubmitting : false,
    isSuccess : false,
    isFailure : true,
  );

  ///
  /// CONSTRUCTOR LOADING
  ///
  factory LoginState.success()=> LoginState(
    isValidEmail : true,
    isValidPassword : true,
    isSubmitting : false,
    isSuccess : true,
    isFailure : false,
  );

  ///
  /// CLONE LOGIN STATE
  /// clonons un object de Loginstate
  /// lorsqu'on a pas de nouveau donnée on recupere celui des donnee courant recu

  LoginState cloneWith(
    {
      final bool isValidEmail,
      final bool isValidPassword,
      final bool isSubmitting,
      final bool isSuccess,
      final bool isFailure,
    }
  ){
    return LoginState(
      isValidEmail : isValidEmail ?? this.isValidEmail,
      isValidPassword : isValidPassword ?? this.isValidPassword,
      isSubmitting : isSubmitting ?? this.isSubmitting,
      isSuccess : isSuccess ?? this.isSuccess,
      isFailure : isFailure ?? this.isFailure,
    );
  }

  ///
  /// comment cloner un objet et mettre à jour cet objet
  ///
   LoginState cloneAndUpdate(
    {
      final bool isValidEmail,
      final bool isValidPassword,
    }
  ){
    return cloneWith(
      isValidEmail : isValidEmail ,
      isValidPassword : isValidPassword,
      isSubmitting : false,
      isSuccess : false,
      isFailure : false,
    );
  }
  
}