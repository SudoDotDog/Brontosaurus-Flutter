import 'package:brontosaurus_flutter/brontosaurus_flutter.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoggedInPage(),
    );
  }
}

class LoggedInPage extends StatelessWidget {
  Widget build(BuildContext context) {
    if (!Brontosaurus.validateToken()) {
      Future.delayed(
          Duration(seconds: 1),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage())));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return BrontosaurusView(
      server: 'https://google.com',
      application: 'TEST',
      next: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoggedInPage())),
    );
  }
}
