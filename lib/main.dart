import 'package:flutter/material.dart';
import 'Tabs.dart';
import 'screen1.dart';

import 'Login.dart';
//import 'Tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Youtube",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.black),
      home: Login(),
    );
  }
}
