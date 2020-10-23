import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Coins extends StatefulWidget {
  const Coins({Key key}) : super(key: key);

  @override
  _CoinsState createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  String selected = "first";

  @override
  Widget build(BuildContext context) {
    List<Widget> _layouts = [
      SizedBox(
        height: 10,
      ),
      _card(),
      SizedBox(
        height: 10,
      ),
      _row1(),
      _row2(),
      SizedBox(
        height: 10,
      ),
      Container(
        padding: EdgeInsets.only(left: 30.0),
        child: Text(
          'Send Coins To',
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        height: 30,
      ),
      _row3(),
      SizedBox(
        height: 30,
      ),
      Container(
        padding: EdgeInsets.only(left: 30.0, right: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            'History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ]),
      ),
      SizedBox(
        height: 10,
      ),
      _row4(),
      SizedBox(
        height: 10,
      ),
      _row5(),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Coins',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
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

Widget _card() {
  return Container(
    padding: EdgeInsets.only(left: 10.0),
    child: ListTile(
      leading: Image.asset(
        'assets/images/Profile-1.png',
        height: 120,
      ),
      title: Text(
        'Channel Name',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        '123k Followers ' + '|' + ' 123k Following',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget _row1() {
  return Container(
    padding: EdgeInsets.only(left: 15.0, right: 25),
    height: 50,
    child: ListTile(
      leading: Text('Balance'),
      trailing: Text('1,500 coins',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
    ),
  );
}

Widget _row2() {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/images/ADD Coin.png',
          width: 150,
          height: 100,
        ),
        Image.asset(
          'assets/images/WITHDRAW.png',
          width: 150,
          height: 100,
        ),
      ],
    ),
  );
}

Widget _row3() {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Image.asset('assets/images/Profile-1.png', height: 70),
      Image.asset('assets/images/Profile-1.png', height: 70),
      Image.asset('assets/images/Profile-1.png', height: 70),
      Image.asset('assets/images/j.png', height: 70),
    ],
  ));
}

Widget _row4() {
  return Padding(
    padding: EdgeInsets.only(left: 12.0),
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
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        '123k Followers ' + '|' + ' 123k Following',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
      ),
      trailing: Text(
        '-1500 coins',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _row5() {
  return Padding(
    padding: EdgeInsets.only(left: 12.0),
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
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        '123k Followers ' + '|' + ' 123k Following',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
      ),
      trailing: Text(
        '+500 coins',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
