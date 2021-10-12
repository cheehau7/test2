import 'package:redux/redux.dart';
import 'package:redux_2/reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

class UpdateQuoteAction {
  String _quote;

  String get quote => this._quote;

  UpdateQuoteAction(this._quote);
}

ThunkAction<AppState> getRandomQuote = (Store<AppState> store) async {
  store.dispatch(new UpdateQuoteAction("Update quote"));
};