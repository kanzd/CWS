import 'package:flutter/material.dart';
import 'Tabs.dart';
import 'screen1.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

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
    return AdaptiveTheme(
      light: ThemeData(primaryColor: Colors.white, accentColor: Colors.black),
      dark: ThemeData( brightness: Brightness.dark,primaryColor: Colors.black, accentColor: Colors.red),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darktheme) => MaterialApp(
        title: "Youtube",
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darktheme,
        home: Login(),
      ),
    );
  }
}
