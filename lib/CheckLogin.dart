import 'Model/DatabaseProvider.dart';
import 'Model/FirebaseDatabaseHelper.dart';
import 'Model/Giocatore.dart';
import 'Model/Giochi/Gioco.dart';

class CheckLogin {
  Future<List<Giocatore>> userIsLogged() async {
    List<Giocatore> giocatori = new List();
    DatabaseProvider databeProvider = new DatabaseProvider();
    FirebaseDatabaseHelper firebaseDatabaseHelper =
        new FirebaseDatabaseHelper();
    giocatori = await databeProvider.getLoggedUser().then((loggedUser) async {
      List<Giocatore> toReturn = new List();
      if (loggedUser != null) {
        Giocatore g = await firebaseDatabaseHelper
            .getGiocatore(loggedUser.name, null)
            .then((giocatore) async {
          List<Gioco> giochi = await firebaseDatabaseHelper
              .getAllGiochi(giocatore.name)
              .then((giochi) {
            return giochi;
          });
          giocatore.giochi = giochi;
        });
        toReturn.add(g);
        return toReturn;
      } else {
        List<Giocatore> list =
            await firebaseDatabaseHelper.getAllGiocatori().then((list) {
          return list;
        });
        toReturn.addAll(list);
        return toReturn;
      }
    });
    return giocatori;
  }
}
