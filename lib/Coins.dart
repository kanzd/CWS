import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp1/services/giftservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Coins extends StatefulWidget {
  Coins({Key key}) : super(key: key);

  @override
  _CoinsState createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  String selected = "first";
  String channelname;
  var followers, following;
  List<Widget> _layouts;
  var balance;
  void getvals() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var data = await GiftService().getvals();
    var doc3 = firestore.doc(pref.getStringList('your info')[3]);
    var docdata = await doc3.get();
    channelname = docdata.data()['name'];
    followers = docdata.data()['followers'];
    following = docdata.data()['following '];
    print(data);
    
    var ls = data['history'].keys.toList().reversed.toList();
    ls.sort();
    balance = data['balance'];
    _layouts = [
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
      // His(),
      // _row4(),
      // SizedBox(
      //   height: 10,
      // ),
      // _row5(),
    ];

    for (var i in ls) {
      print(i);
      var doc = firestore.doc('videos/' + i.split(',')[0]);
      var docdata = await doc.get();

      _layouts.add(ListTile(
        leading: Icon(Icons.supervised_user_circle),
        title: Text(docdata.data()['name']),
        subtitle: Text("Following"),
        trailing: Text("${data['history'][i]} Coins"),
      ));
    }
    setState(() {
      flag = false;
    });
  }

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    if (flag) getvals();
    if (!flag)
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
          key: GlobalKey(),
          children: <Widget>[
            Expanded(
              child: ListView(
                children: _layouts,
              ),
            ),
            // _row4(),
          ],
        ),
        //     body:CustomScrollView(
        //   slivers: [
        //     SliverAppBar(
        //        expandedHeight: 450.0
        //       ,
        //     flexibleSpace: FlexibleSpaceBar(title:Expanded(

        //           child: ListView(
        //             children: _layouts,
        //           ),
        //         ),),),
        //     SliverList(
        //       delegate: SliverChildBuilderDelegate((context, index) {
        //         return ListTile(leading: Icon(Icons.supervised_user_circle_sharp),title: Text('name'),subtitle: Text('following'),trailing: Text('-100 Coins'),);
        //       }),
        //     )
        //   ],
        // ) ,
      );
    else
      return SpinKitFadingCube(color: Colors.blue[300]);
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
          '$channelname',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '$followers Followers ' + '|' + ' $following Following',
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
      key: GlobalKey(),
      padding: EdgeInsets.only(left: 15.0, right: 25),
      height: 50,
      child: ListTile(
        leading: Text('Balance'),
        trailing: Text('$balance coins',
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
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              leading: Icon(Icons.supervised_user_circle_sharp),
              title: Text('name'),
              subtitle: Text('following'),
              trailing: Text('-100 Coins'),
            );
          }),
        )
      ],
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
}

class His extends StatefulWidget {
  @override
  _HisState createState() => _HisState();
}

class _HisState extends State<His> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              leading: Icon(Icons.supervised_user_circle_sharp),
              title: Text('name'),
              subtitle: Text('following'),
              trailing: Text('-100 Coins'),
            );
          }),
        )
      ],
    );
  }
}
