import 'Model/DatabaseProvider.dart';
import 'Model/FirebaseDatabaseHelper.dart';
import 'Model/Giocatore.dart';

class CheckLogin {
  Future<List<Giocatore>> userIsLogged() async {
    List<Giocatore> giocatori = new List();
    DatabaseProvider databeProvider = new DatabaseProvider();
    Giocatore loggedUser = await databeProvider.getLoggedUser();
    if (loggedUser != null) {
      giocatori.add(loggedUser);
      return giocatori;
    } else {
      FirebaseDatabaseHelper firebaseDatabaseHelper =
          new FirebaseDatabaseHelper();
      List<Giocatore> list = await firebaseDatabaseHelper.getAllGiocatori();
      giocatori.addAll(list);
      return giocatori;
    }
  }
}
