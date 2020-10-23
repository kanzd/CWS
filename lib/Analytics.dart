import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  String selected = "first";

  @override
  Widget build(BuildContext context) {
    List<Widget> _layouts = [
      SizedBox(
        height: 10,
      ),
      _card(),
      SizedBox(
        height: 25,
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = 'first';
                });
              },
              child: Container(
                height: 70,
                width: 200,
                color: selected == 'first'
                    ? Colors.lightBlueAccent
                    : Colors.transparent,
                child: ListTile(
                  title: Text(
                    "₹ 1.5k",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'Revenue',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = 'Second';
                });
              },
              child: Container(
                height: 70,
                width: 200,
                color: selected == 'Second'
                    ? Colors.lightBlueAccent
                    : Colors.transparent,
                child: ListTile(
                  title: Text(
                    "₹ 5k",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'Users Over time',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 35,
      ),
      Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListTile(
          leading: Text(
            'Revenue',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          trailing: Text(
            'Transaction',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              '    ₹ 1.5k',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 40),
//            Image.asset(''),
            Text(
              '₹ 1.5k(36.67%)',
            ),
            SizedBox(width: 170),

            Text(
              '18',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Analytics',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: _layouts,
            ),
          ),
          Expanded(
            child: Container(
              height: 400,
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Sparkline(
                data: [
                  200.0,
                  160.0,
                  280.5,
                  200.0,
                  300.0,
                  200.0,
                  200.5,
                  230.0,
                  140.5,
                  160.0,
                  200.0
                ],
                fillMode: FillMode.below,
                fillColor: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _card() {
  return Container(
    height: 70,
    child: ListTile(
      leading: Image.asset(
        'assets/images/Profile-1.png',
        height: 100,
      ),
      title: Text(
        'Channel Name',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        '123k Followers ' + '|' + ' 123k Following',
        style: TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
      ),
    ),
  );
}
