import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp1/services/fileselect.dart';
import 'package:newapp1/services/videos.dart';
import 'package:newapp1/upload_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'All Videos.dart';
import 'Analytics.dart';
import 'Coins.dart';
import 'Constants.dart';
import 'NewUploads.dart';
import 'Setting.dart';
import './services/videos.dart';

//
class Channel extends StatefulWidget {
  var docid;
  Channel({Key key, docid}) : super(key: key) {
    this.docid = docid;
  }

  @override
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<Channel> with TickerProviderStateMixin {
  double screenSize;
  double screenRatio;
  AppBar appBar;
  List<Tab> tabList = List();
  TabController _tabController;
  @override
  void initState() {
    tabList.add(new Tab(
      text: 'New Uploads',
    ));
    tabList.add(new Tab(
      text: 'All Videos',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  var data;
  bool flag = false;
  String s1 = '';

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    data = await Videos(
            docid: widget.docid == null
                ? pref.getStringList('your info')[3]
                : widget.docid)
        .getData();
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(widget.docid == null
        ? pref.getStringList('your info')[3]
        : widget.docid);
    var docdata = await doc.get();
    s1 = docdata.data()['name'];
    setState(() {
      flag = true;
    });
  }

  Widget _GetPage(Tab tab) {
    switch (tab.text) {
      case 'New Uploads':
        return NewUploads(docid: widget.docid);
      case 'All Videos':
        return AllVideos(docid:widget.docid);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!flag) getData();
    screenSize = MediaQuery.of(context).size.width;
    appBar = AppBar(
      centerTitle: true,
      title: Text('Channel'),
      leading: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return Constants.Choices.map(
              (String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              },
            ).toList();
          },
        )
      ],
    );
    if (flag)
      return Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            new Container(
              height: 200,
              width: screenSize,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("images/app_image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            RefreshIndicator(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: appBar,
                body: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
                          child: SizedBox(
                              height: 200,
                              child: Column(
                                children: [
//                            SizedBox(height: 30),
                                  ListTile(
                                    leading: Image.asset(
                                        'assets/images/Profile-1.png'),
                                    title: Text(
                                      '$s1',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/QWEQ.png',
                                      height: 50,
                                      width: 150,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 20,
                                      child: ListTile(
                                          leading: Text(
                                            '${data['videos'].keys.toList().length}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          title: Center(
                                            child: Text(
                                              '${data['followers']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          trailing: Text(
                                            '${data['following ']}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: SizedBox(
                                      height: 20,
                                      child: ListTile(
                                          leading: Text(
                                            'Videos',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          title: Center(
                                            child: Text(
                                              'Follower',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          trailing: Text(
                                            'Following',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    new Positioned(
                      width: screenSize,
                      top: 180,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              decoration: new BoxDecoration(
                                  color: Theme.of(context).primaryColor),
                              child: new TabBar(
                                  controller: _tabController,
                                  indicatorColor: Colors.pink,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: tabList),
                            ),
                            new Container(
                              height: 500.0,
                              child: new TabBarView(
                                controller: _tabController,
                                children: tabList.map((Tab tab) {
                                  return _GetPage(tab);
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onRefresh: () {
                flag = true;
                setState(() {});
              },
            ),
          ],
        ),
      );
    else
      return SpinKitFadingFour(
        color: Colors.blue,
      );
  }

  void choiceAction(String choice) {
    if (choice == 'Setting') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Setting()),
      );
    } else if (choice == 'Coins') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Coins()),
      );
    } else if (choice == 'Analytics') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Analytics()),
      );
    } else if (choice == 'upload video') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Upload_Screen()));
    }
  }
}
