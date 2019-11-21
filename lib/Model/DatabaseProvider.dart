import 'package:flutter_app/Model/Giocatore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Giochi/Gioco.dart';

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
    String path = 'assets/persistance/' + 'appunti.db';
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
}
