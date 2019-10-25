import 'Model/Giocatore.dart';

abstract class BaseAggiungiGiocatori {
  bool canGoNext();

  List<Giocatore> onFabClick();
}
