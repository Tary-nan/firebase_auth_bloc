

import 'package:firebase_auth_bloc/couterBloc/events/counter_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int>{
  CounterBloc(int initialState) : super(initialState);
  
  @override
  Stream<int> mapEventToState(CounterEvent event) async*{
    switch (event) {
      case CounterEvent.increment:
        var newState = state +1;
        yield newState;
        break;
      case CounterEvent.decrement:
      var newState = state - 1;
        yield newState;
        break;
      default:
    }
  }
}