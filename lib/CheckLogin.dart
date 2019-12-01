import 'Model/DatabaseProvider.dart';
import 'Model/FirebaseDatabaseHelper.dart';
import 'Model/Giocatore.dart';

class CheckLogin {
  Future<List<Giocatore>> userIsLogged() async {
    List<Giocatore> giocatori = new List();
    DatabaseProvider databeProvider = new DatabaseProvider();
    giocatori = await databeProvider.getLoggedUser().then((loggedUser) async {
      List<Giocatore> toReturn = new List();
      if (loggedUser != null) {
        toReturn.add(loggedUser);
        return toReturn;
      } else {
        FirebaseDatabaseHelper firebaseDatabaseHelper =
            new FirebaseDatabaseHelper();
        List<Giocatore> list = await firebaseDatabaseHelper.getAllGiocatori().then((list){
          return list;
        });
        toReturn.addAll(list);
        return toReturn;
      }
    });
    return giocatori;
  }
}
