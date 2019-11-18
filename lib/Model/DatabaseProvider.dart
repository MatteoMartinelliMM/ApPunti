import 'package:flutter_app/Model/Giocatore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await getDatabaseInstance();
    return _db;
  }

  getDatabaseInstance() async {
    String path = 'assets/persistance/' + 'appunti.db';
    return await openDatabase(path, version: 1,onOpen: (db){},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Giocatore ("
          "name TEXT PRIMARY KEY,"
          "number TEXT,"
          "url TEXT,"
          "darkMode INTEGER DEFAULT 0"
          ")");
      await db.execute("CREATE TABLE Gioco ("
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
    return await _db.insert("Giocatore", g.giocatoreAsDbMap());
  }
}
