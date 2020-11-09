import 'package:firebase_auth_bloc/events/login_event.dart';
import 'package:firebase_auth_bloc/repositories/user_repository.dart';
import 'package:firebase_auth_bloc/states/login_state.dart';
import 'package:firebase_auth_bloc/validators/validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  UserRepository _userRepository;
  LoginBloc({@required UserRepository userRepository}) : 
    assert(userRepository != null),
    _userRepository = userRepository,
    super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent)async* {
    final loginState = state;
    if (loginEvent is LoginEventEmailChanged) {
      yield loginState.cloneAndUpdate(isValidEmail: Validation.isValidEmail(loginEvent.email));
      
    }else if(loginEvent is LoginEventPasswordChanged){
      yield loginState.cloneAndUpdate(isValidPassword: Validation.isValidPassword(loginEvent.password));

    }else if(loginEvent is LoginEventWithEmailPasswordPressed){
      print('login');
      print(Validation.isValidEmail(loginEvent.email));
      print(Validation.isValidPassword(loginEvent.password));
      try{
        await _userRepository
          .signInWithEmailAndPassword(
            email: loginEvent.email, 
            password: loginEvent.password)
            .then((value) {
              print('ressir');
            });
        yield LoginState.success();
      }catch(_){
        print(_);
        yield LoginState.failure();
      }

    }else if(loginEvent is LoginEventWithGooglePressed){
      try{
        await _userRepository.signInWithGoogle();
        yield LoginState.success();
      }catch(_){
        yield LoginState.failure();
      }
    }
  }
  
}