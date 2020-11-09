import 'package:firebase_auth_bloc/events/login_event.dart';
import 'package:firebase_auth_bloc/events/register_event.dart';
import 'package:firebase_auth_bloc/repositories/user_repository.dart';
import 'package:firebase_auth_bloc/states/login_state.dart';
import 'package:firebase_auth_bloc/states/registration_state.dart';
import 'package:firebase_auth_bloc/validators/validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  UserRepository _userRepository;
  RegisterBloc({@required UserRepository userRepository}) : 
    assert(userRepository != null),
    _userRepository = userRepository,
    super(RegisterState.initial());


    @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(Stream<RegisterEvent> registerEvents, transitionFn) {
     //  a chaque que je reçois une event verifie si l'un de ses champs a des donnée
    final debounceStream = registerEvents.where((event) => event is RegisterEventEmailChanged || event is RegisterEventPasswordChanged)
                              .debounceTime(Duration(milliseconds: 300));
    // lorsqu'il y aucun changement
    final nondebounceStream = registerEvents.where((event) => event is! RegisterEventEmailChanged && event is! RegisterEventPasswordChanged);
    return super.transformEvents(nondebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent registerEvent)async* {
    final registerState = state;
    if (registerEvent is RegisterEventEmailChanged) {
      yield registerState.cloneAndUpdate(isValidEmail: Validation.isValidEmail(registerEvent.email));
      
    }else if(registerEvent is RegisterEventPasswordChanged){
      yield registerState.cloneAndUpdate(isValidPassword: Validation.isValidEmail(registerEvent.password));

    }else if(registerEvent is RegisterEventPressed){
      try{
        await _userRepository
          .createUserWithEmailAndPassword(
            email: registerEvent.email, 
            password: registerEvent.password);
        yield RegisterState.success();
      }catch(_){
        yield RegisterState.failure();
      }
    }
  }
}