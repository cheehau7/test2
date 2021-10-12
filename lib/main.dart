// ignore_for_file: prefer_const_constructors, unnecessary_new, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_2/action.dart';
import 'package:redux_2/reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';

//type actions
enum Types {Clicl, Increment, AddQuote}

//connect store
final store = new Store<AppState> (
  reducers,
  initialState: AppState(count: 1, clickCount: 0, quote: "Default Quote"),
  middleware: [thunkMiddleware],
);

void main() {
  runApp(MyApp(
    store: store,

  ));
}


class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new StoreProvider(
      store: store,
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: "Simple State Management",
        home: Scaffold(
          appBar: AppBar(
            title: Text('State management'),

          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StoreConnector<AppState, int>(
                  builder: (_, count){
                  return Text('$count');
                },
                 converter: (store) => store.state.count),
                 StoreConnector<AppState, GenerateQuote>(
                   builder: (_, quote) {
                     // ignore: unnecessary_new
                     return new TextButton(
                       
                       onPressed: quote, 
                       child: Text('Change Quote'));
                   }, 
                   converter: (store) => () => store.dispatch(getRandomQuote))
              ]
            ),
          ),
          floatingActionButton: StoreConnector<AppState, IncrementCounter>(
            builder: (_, incrementCallback) {
              return new FloatingActionButton(
                onPressed: incrementCallback,
                tooltip: 'ADD',
                child: Icon(Icons.add),
                
                 );
            }, 
            converter: (store) => () => store.dispatch(Types.Increment)),
        ),
      ),
      
    );
  }
}

typedef IncrementCounter = void Function();
typedef GenerateQuote = void Function();