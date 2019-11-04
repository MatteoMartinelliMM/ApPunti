import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseHelper {
  final databaseReference = FirebaseDatabase.instance.reference();

  void createChild(int wo) {
    String title = "gesu" + wo.toString();
    databaseReference.child("dio" + wo.toString()).set({'title': title});
  }
}
