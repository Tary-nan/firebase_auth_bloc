
import 'package:firebase_auth_bloc/couterBloc/blocs/counter_bloc.dart';
import 'package:firebase_auth_bloc/couterBloc/events/counter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBlocPaga extends StatelessWidget {

  Stream<int> asStreamFunction()async*{
    yield 2;
    yield 5;
    yield 7;
    yield 1;
  }
  @override
  Widget build(BuildContext context) {

    final asStream = this.asStreamFunction();
    asStream.forEach((element) {
      print(element);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context)=> CounterBloc(0),
        child: Page(),
      ),
    );
  }
}

class Page extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final bloc = context.bloc<CounterBloc>();
    //bloc.close();

    return Scaffold(
          body: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children : <Widget>[

              Container( 
                width: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  onPressed: (){
                    bloc.add(CounterEvent.increment);

                  }, child: Text("+1"), color: Colors.blueAccent),
              ),

              BlocBuilder<CounterBloc, int>(
                builder: (context, counter) {
                  return Text(counter.toString());
                }
              ),

              Container(
                width: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  onPressed: (){
                     bloc.add(CounterEvent.decrement);

                  }, child: Text("-1"), color: Colors.blueAccent),
              )

            ]
          )
          )
        );
  }
}