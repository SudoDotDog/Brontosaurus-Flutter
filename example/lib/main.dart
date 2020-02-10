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

class LoggedInPage extends StatefulWidget {
  @override
  LoggedInPageState createState() => LoggedInPageState();
}

class LoggedInPageState extends State<LoggedInPage> {
  @override
  void initState() {
    super.initState();
    if (!Brontosaurus.validateToken()) {
      Future(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } else {
      Brontosaurus.reset();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    // return BrontosaurusView(
    //   appBar: AppBar(
    //     title: Text('Login'),
    //   ),
    //   server: 'https://example.com',
    //   application: 'Example',
    //   next: () {
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => LoggedInPage()));
    //   },
    // );

    return BrontosaurusViewLite(
      appBar: AppBar(
        title: Text('Login'),
      ),
      server: 'https://example.com',
      application: 'Example',
      next: (String token) {
        print(token);
      },
    );
  }
}
