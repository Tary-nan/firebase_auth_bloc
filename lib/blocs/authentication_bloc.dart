import 'package:firebase_auth_bloc/events/authentication_event.dart';
import 'package:firebase_auth_bloc/events/login_event.dart';
import 'package:firebase_auth_bloc/repositories/user_repository.dart';
import 'package:firebase_auth_bloc/states/authentication_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository}):
    assert(userRepository != null),
    _userRepository = userRepository,
    super(AuthenticationStateInitial());// Initial state

  //Donnez à 2 événements adjacents un temps de rebond
  @override
  Stream<Transition<AuthenticationEvent, AuthenticationState>> transformEvents(Stream<AuthenticationEvent> loginEvents, transitionFn) {
    //  a chaque que je reçois une event verifie si l'un de ses champs a des donnée
    final debounceStream = loginEvents.where((event) => event is LoginEventEmailChanged || event is LoginEventPasswordChanged)
                              .debounceTime(Duration(milliseconds: 300));
    // lorsqu'il y aucun changement
    final nondebounceStream = loginEvents.where((event) => event is! LoginEventEmailChanged && event is! LoginEventPasswordChanged);
    return super.transformEvents(nondebounceStream, transitionFn);
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent authentication)async* {
    // condition sur les diff events
    if(authentication is AuthenticationEventStarted){
      // isSignIn
      final isSignIn = await _userRepository.isSignedIn();
      if(isSignIn){
        // get user
        final firebaseUser = await _userRepository.getUser();
        //Succès de l'État d'authentification
        yield AuthenticationStateSuccess(firebaseUser: firebaseUser);
      }else{
        yield AuthenticationStateFailed();
      }
      //Connexion à l'événement d'authentification
    }else if(authentication is AuthenticationEventLoggedIn){
      yield AuthenticationStateSuccess(firebaseUser: await _userRepository.getUser());
      //DeConnexion à l'événement d'authentification
    }else if(authentication is AuthenticationEventLoggOut){
      await _userRepository.signOut();
      yield AuthenticationStateFailed();
    }
  }   
}