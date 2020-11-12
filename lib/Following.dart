import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newapp1/models/Followingmodels.dart';
import 'package:newapp1/services/videos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class Following extends StatefulWidget {
  const Following({Key key}) : super(key: key);

  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  var allvals;
  var info;
  List follow;
  bool flag = false;
  void fun() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = await Videos(docid: pref.getStringList('your info')[3])
        .getFollwersList();
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(pref.getStringList('your info')[3]);
    var docdata = await doc.get();
    var data1 = docdata.data();
    info = {
      'name': data1['name'],
      'followers': data1['followers'],
      'following': data1['following ']
    };
    var val = await FollowingModel(
            name: pref.getStringList('your info')[3],
            followers: data['followers'],
            following: data['following'])
        .extractdataFollowing();
    allvals = val[0];
    follow = val[1];
    setState(() {
      flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!flag) fun();
    // List<Widget> _layouts = [
    //   SizedBox(
    //     height: 25,
    //   ),
    //   _card(),
    //   SizedBox(height: 25),
    //   Container(
    //     padding: EdgeInsets.only(left: 20),
    //     child: Text(
    //       'Following',
    //       style: TextStyle(
    //         fontSize: 20,
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    //   SizedBox(height: 25),
    //   _cardList(),
    //   SizedBox(height: 10),
    //   _cardList(),
    //   SizedBox(height: 10),
    //   _cardList1(),
    //   SizedBox(height: 10),
    //   _cardList(),
    //   SizedBox(height: 10),
    //   _cardList1(),
    //   SizedBox(height: 10),
    //   _cardList(),
    // ];
    if (flag)
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Icon(Icons.arrow_back),
          title: Text(
            'Following',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(delegate: SliverChildBuilderDelegate((context, index) {
              if (index < allvals.length)
                return _cardList(
                    index: index,
                    dplink: allvals[index]['dplink'],
                    docid: allvals[index]['docid'],
                    name: allvals[index]['name'],
                    followers: allvals[index]['followers']);
            }))
          ],
        ),
      );
    else
      return SpinKitFadingCircle(
        color: Colors.blue,
      );
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
          info['name'],
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(
          '${info["followers"]} Followers ' +
              '|' +
              ' ${info["following"]} Following',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _cardList({String name, int followers, int index, String docid,String dplink}) {
    print(name);
    return Container(
        height: 70,
        child: ListTile(
            leading: CircularProfileAvatar(
                                      '$dplink',
                                      radius: 30,
                                    ),
            title: Text(
              '$name',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            subtitle: Text('$followers followers'),
            trailing: FlatButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                await Firebase.initializeApp();
                var firestore = FirebaseFirestore.instance;
                var temp = firestore.doc(pref.getStringList('your info')[3]);
                var data = await temp.get();
                
                var doc = firestore.doc(pref.getStringList('your info')[3]);

                var doc2 = firestore.doc(docid);
                var docdata = await doc.get();
                var docdata2 = await doc2.get();
                var data1 = docdata.data();
                var data2 = docdata2.data();
                follow[index][name] == 'Follow'
                    ? data1['following ']++
                    : data1['following ']--;
                follow[index][name] == 'Follow'
                    ? data2['followers']++
                    : data2['followers']--;
                follow[index][name] == 'Follow'
                    ? data1['following-name'][name] = docid
                    : data1['following-name'][name] = null;
                follow[index][name] == 'Follow'
                    ? data2['followers-name'][data.data()['name']] = docid
                    : data2['followers-name'][data.data()['name']] = null;
                await doc.update(data1);
                await doc2.update(data2);
                setState(() {
                  follow[index][name] =
                      follow[index][name] == 'Follow' ? 'Following' : "Follow";
                });
              },
              child: Text(
                follow[index][name],
                style: TextStyle(color: Colors.blue),
              ),
            )));
  }

  Widget _cardList1() {
    return Container(
        height: 70,
        child: ListTile(
          leading: Image.asset('assets/images/Profile-1.png'),
          title: Text(
            'Channel Name',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          trailing: Image.asset(
            'assets/images/Follow Button.png',
            height: 50,
            width: 140,
          ),
          subtitle: Text('123k followers'),
        ));
  }
}
