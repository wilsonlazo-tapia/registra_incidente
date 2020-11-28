import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrreaderapp/src/pages/login_page.dart';
import 'package:qrreaderapp/src/pages/register_page.dart';
import 'package:qrreaderapp/src/pages/registrar_incidente.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      home: RegistrarIncidente(),
      routes: {
        RegisterPage.routeName: (_) => RegisterPage(),
        LoginPage.routeName: (_) => LoginPage(),
        'RegistroIcidente': (BuildContext context) => RegistrarIncidente(),
      },
      theme: ThemeData(primaryColor: Colors.lightBlue),
    );
  }
}
