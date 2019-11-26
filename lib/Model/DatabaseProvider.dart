import 'package:flutter_app/Model/Giocatore.dart';
import 'package:flutter_app/Model/Giochi/BriscolaAChiamata.dart';
import 'package:flutter_app/Model/Giochi/Cirulla.dart';
import 'package:flutter_app/Model/Giochi/ScoponeGioco.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Constants.dart';
import 'FirebaseConstans.dart';
import 'Giochi/Asse.dart';
import 'Giochi/Briscola.dart';
import 'Giochi/Gioco.dart';
import 'Giochi/Presidente.dart';
import 'Giochi/Scopa.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  Database _db;

  factory DatabaseProvider() {
    return _instance;
  }

  DatabaseProvider._internal() {}

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await getDatabaseInstance();
    return _db;
  }

  Future getDatabaseInstance() async {
    String path =
        await getDatabasesPath() + '/assets/persistance/' + 'appunti.db';
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $Giocatore ("
          "name TEXT PRIMARY KEY,"
          "numero TEXT,"
          "url TEXT,"
          "darkMode INTEGER DEFAULT 0"
          ")");
      await db.execute("CREATE TABLE $Gioco ("
          "gioco TEXT PRIMARY KEY,"
          "partiteGiocate INTEGER,"
          "partiteVinte INTEGER,"
          "schiavo INTEGER,"
          "puntiFatti INTEGER,"
          "puntiFattiBrChiamata DOUBLE,"
          "playerName TEXT,"
          "FOREIGN KEY(playerName) REFERENCES Giocatore(name)"
          ")");
    });
  }

  Future<int> addUser(Giocatore g) async {
    Database db = await database;
    return db.insert("Giocatore", g.giocatoreAsDbMap());
  }

  Future<int> updateDarkMode(Giocatore g) async {
    Database db = await database;
    return db.update("Giocatore", g.darkModeAsMap());
  }

  Future<Giocatore> selectLoggedUser(String name) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query("Giocatore", where: "name = ? ", whereArgs: [name]);
    return result.isNotEmpty ? new Giocatore.fromDbMap(result[0]) : null;
  }

  Future<int> addGioco(Gioco g, String nomePlayer) async {
    Database db = await database;
    var asDbMap = g.asDbMap();
    asDbMap[PLAYER_NAME] = nomePlayer;
    return db.insert("Gioco", g.asDbMap());
  }

  Future<int> updateGioco(Gioco g, String nomePlayer) async {
    Database db = await database;
    var asDbMap = g.asDbMap();
    asDbMap[PLAYER_NAME] = nomePlayer;
    return db.update("Gioco", asDbMap);
  }

  Future insertAllGiochi(List<Gioco> giochi, String nomePlayer) async {
    Database db = await database;
    db.transaction((db) {
      giochi.forEach((g) async {
        var asDbMap = g.asDbMap();
        asDbMap["playerName"] = nomePlayer;
        await db.insert("Gioco", asDbMap);
      });
    });
  }

  Future<List<Gioco>> selectAllGiochiByUsername(String name) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query("Gioco", where: "playerName = ? ", whereArgs: [name]);
    List<Gioco> giochi = new List();
    for (Map<String, dynamic> r in result) {
      Gioco g;
      switch (r["gioco"]) {
        case BRISCOLA:
          g = Briscola.fromDbMap(r);
          break;
        case BRISCOLA_A_CHIAMATA:
          g = BriscolaAChiamata.fromDbMap(r);
          break;
        case SCOPONE_SCIENTIFICO:
          g = ScoponeGioco.fromDbMap(r);
          break;
        case SCOPA:
          g = Scopa.fromDbMap(r);
          break;
        case CIRULLA:
          g = Cirulla.fromDbMap(r);
          break;
        case ASSE:
          g = Asse.fromDbMap(r);
          break;
        case PRESIDENTE:
          g = Presidente.fromDbMap(r);
          break;
      }
      giochi.add(g);
    }
    return giochi;
  }
}
