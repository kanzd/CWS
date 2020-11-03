import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var userinfo;
  void getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc('/user/3eegwiaV0kADBBbCzcmd');
    var docdata = await doc.get();
    userinfo = docdata.data()[pref.getStringList('your info')[1].split('.')[0]];
    userinfo['email'] = pref.getStringList('your info')[1];
    setState(() {
      val = true;
    });
  }

  bool val = false;
  @override
  Widget build(BuildContext context) {
    getdata();
    if (val)
      return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          centerTitle: true,
        ),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 50),
            decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(60)),
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                ListTile(
                  title: Text('Name'),
                  subtitle: Text('${userinfo['name']}'),
                  leading: Icon(Icons.info),
                ),
                ListTile(
                  title: Text("Email"),
                  subtitle: Text('${userinfo['email']}'),
                  leading: Icon(Icons.email),
                ),
                ListTile(
                    title: Text('Phone No.'),
                    subtitle: Text('${userinfo['number']}'),
                    leading: Icon(Icons.phone))
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 90, top: 10),
              child: CircularProfileAvatar(
                'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                radius: 90,
              )),
        ]),
      );
    else
      return SpinKitFadingCube(color: Colors.blue[300]);
  }
}
