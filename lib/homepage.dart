import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'CheckLogin.dart';
import 'LoginPage.dart';
import 'Model/Constants.dart';
import 'SelezionaGioco.dart';

main() => runApp(ContaPunti());

class ContaPunti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
    widget.checkLogin.userIsLogged().then((giocatori) {
      if (giocatori.length > 1) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new LoginPage(giocatori)));
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => new HomePage(giocatori[0])));
        });
      }
    });
    return loadingScreen();
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
