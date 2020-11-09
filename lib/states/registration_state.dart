import 'package:flutter/material.dart';

/// Une classe est immuable si tous les champs d'instance de la classe, ne chande pas
/// définis directement ou hérités, sont "définitifs".
@immutable
class RegisterState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isValidEmailAndiPassword => isValidEmail && isValidPassword; // comment faire la validation

  ///
  /// CONSTRUCTOR
  ///
  RegisterState({
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
  factory RegisterState.initial()=> RegisterState(
    isValidEmail : true,
    isValidPassword : true,
    isSubmitting : false,
    isSuccess : false,
    isFailure : false,
  );

  ///
  /// CONSTRUCTOR LOADING
  ///
  factory RegisterState.loading()=> RegisterState(
    isValidEmail : true,
    isValidPassword : true,
    isSubmitting : true,
    isSuccess : false,
    isFailure : false,
  );

  ///
  /// CONSTRUCTOR LOADING
  ///
  factory RegisterState.failure()=> RegisterState(
    isValidEmail : true,
    isValidPassword : true,
    isSubmitting : false,
    isSuccess : false,
    isFailure : true,
  );

  ///
  /// CONSTRUCTOR LOADING
  ///
  factory RegisterState.success()=> RegisterState(
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

  RegisterState cloneWith(
    {
      final bool isValidEmail,
      final bool isValidPassword,
      final bool isSubmitting,
      final bool isSuccess,
      final bool isFailure,
    }
  ){
    return RegisterState(
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
   RegisterState cloneAndUpdate({
    final bool isValidEmail,
    final bool isValidPassword,
   }
   ){
    return cloneWith(
      isValidEmail : isValidEmail ,
      isValidPassword : isValidPassword,
    );
  }
  
}