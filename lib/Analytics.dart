import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp1/services/giftservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var data = await GiftService().getvals();
    var doc = firestore.doc(pref.getStringList('your info')[3]);
    var datadoc = await doc.get();
    name = datadoc['name'];
    following = datadoc['following '];
    followers = datadoc['followers'];
    rev = data['balance'] * 5;
    var ls = data['history'].keys.toList().reversed.toList();
    tras = ls.length;
    for (var i in ls) {
      this.data.add(data['history'][i].toDouble());
    }
    setState(() {
      b1 = false;
    });
  }

  String selected = "first";
  String name = 'channel';
  int following = 0;
  int followers = 0;
  int rev = 0;
  int tras = 0;
  List<double> data = [];
  bool b1 = true;
  @override
  Widget build(BuildContext context) {
    getData();
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
                    "₹ $rev",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'Revenue',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       selected = 'Second';
            //     });
            //   },
            //   child: Container(
            //     height: 70,
            //     width: 200,
            //     color: selected == 'Second'
            //         ? Colors.lightBlueAccent
            //         : Colors.transparent,
            //     child: ListTile(
            //       title: Text(
            //         "₹ 5k",
            //         textAlign: TextAlign.center,
            //       ),
            //       subtitle: Text(
            //         'Users Over time',
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //   ),
            // ),
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
              '    ₹ $rev',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 40),
//            Image.asset(''),
            Text(
              '₹ $rev',
            ),
            SizedBox(width: 100),

            Text(
              '$tras',
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

    if (!b1)
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
            //       Container(child:

            //       LineChart(
            //   lines: [
            //     new Line<List<String>, String, String>(
            //       data: [['1','3'],['2','4']],
            //       xFn: (datum) => datum[0],
            //       yFn: (datum) => datum[1],
            //     ),
            //   ],
            //   chartPadding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 30.0),
            // ),),
            Container(
              height: 220,
              padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),
              child: Sparkline(
                data: this.data,
                fillMode: FillMode.below,
                fillGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue[300], Colors.white],
                ),
                lineWidth: 5.0,
                pointSize: 8.0,
                lineColor: Colors.blue[300],
                pointColor: Colors.purple,
                sharpCorners: true,
                pointsMode: PointsMode.all,
              ),
            ),
          ],
        ),
      );
    else
      return SpinKitFadingGrid(color: Colors.blue[300]);
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
          '$name',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          '$followers Followers ' + '|' + ' $following Following',
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
