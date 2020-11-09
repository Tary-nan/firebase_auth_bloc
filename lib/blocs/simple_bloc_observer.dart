import 'package:flutter_bloc/flutter_bloc.dart';

class  SimpleBlocObserver extends BlocObserver {
  //cela vous permet de voir l'historique des événements du bloc
  
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
  }
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
  }
  
}