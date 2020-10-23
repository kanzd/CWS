import 'package:flutter/material.dart';
import 'VideoInfo.dart';

class Subscriptioins extends StatefulWidget {
  Subscriptioins({Key key}) : super(key: key);

  _SubscriptioinsState createState() => _SubscriptioinsState();
}

class _SubscriptioinsState extends State<Subscriptioins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Following"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.account_circle, color: Colors.blue),
            onPressed: () {}),
      ),
      body: VideoFeed(),
    );
  }
}
