import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _layouts = [
      SizedBox(height: 50),
      Container(
        padding: EdgeInsets.only(left: 25.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/Path 261.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 20),
            Text(
              'General',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 30),
      Container(
        padding: EdgeInsets.only(left: 25.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/Lock.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 20),
            Text(
              'Privacy and Security',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 30),
      Container(
        padding: EdgeInsets.only(left: 25.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/aCCOUNT.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 20),
            Text(
              'Account',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 30),
      Container(
        padding: EdgeInsets.only(left: 25.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/half.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 20),
            Text(
              'Change to Light Theme',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 30),
      Container(
        padding: EdgeInsets.only(left: 25.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/Path 148.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 20),
            Text(
              'Billing & Payments',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 30),
      Container(
        padding: EdgeInsets.only(left: 25.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/Path 146.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 20),
            Text('About'),
          ],
        ),
      ),
      SizedBox(height: 30),
      Container(
        padding: EdgeInsets.only(left: 25.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/Path 151.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 20),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          'Settings',
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: _layouts,
            ),
          ),
        ],
      ),
    );
  }
}