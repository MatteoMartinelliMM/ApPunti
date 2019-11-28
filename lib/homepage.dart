import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Model/DatabaseProvider.dart';

import 'CheckLogin.dart';
import 'Model/Constants.dart';
import 'Model/Giocatore.dart';
import 'SelezionaGioco.dart';

main() => runApp(ContaPunti());

class ContaPunti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    DatabaseProvider db = new DatabaseProvider();
    db.addUser(new Giocatore('Mimmo'));
    return MaterialApp(
      title: 'Conta punti',
      theme: ThemeData.dark(),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new HomePage(null)
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  CheckLogin checkLogin = new CheckLogin();

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.checkLogin.userIsLogged(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return loadingScreen();
              break;
            case ConnectionState.done:
              List<Giocatore> giocatori = snapshot.data;
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new HomePage(giocatori)));
              });
              return loadingScreen();
          }
        });
  }

  Widget loadingScreen() {
    return Container(
      color: Color(0xFFE4D700),
      child: Center(
        child: Image.asset(IMAGE_PATH + 'splash_logo.png'),
      ),
    );
  }
}
