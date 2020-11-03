import 'package:flutter/material.dart';

class GenPage extends StatefulWidget {
  @override
  _GenPageState createState() => _GenPageState();
}

class _GenPageState extends State<GenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('General'),
          centerTitle: true,
        ),
        body: Center(child: Text('No info yet')));
  }
}
