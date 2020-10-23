import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Analytics.dart';
import 'Channel_Page.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'Coins.dart';
import 'Following.dart';
import 'Setting.dart';
import 'VideoInfo.dart';
import 'Video_details.dart';
import 'screen3.dart';

// Main code for all the tabs
class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  static final homePageKey = GlobalKey<MyTabsState>();
  TabController tabcontroller;

  @override
  void initState() {
    super.initState();
    tabcontroller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    tabcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homePageKey,
      bottomNavigationBar: new Material(
          child: new TabBar(
              controller: tabcontroller,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.blue,
              labelStyle: TextStyle(fontSize: 11.0),
              tabs: <Tab>[
            new Tab(
              icon: Image.asset(
                'assets/images/Group 156.png',
                height: 35,
                width: 35,
              ),
            ),
            new Tab(
              icon: Image.asset(
                'assets/images/Group 160.png',
                height: 35,
                width: 35,
              ),
            ),
            new Tab(
              icon: Image.asset(
                'assets/images/Group 164.png',
                height: 35,
                width: 35,
              ),
            ),
          ])),
      body: TabBarView(
        controller: tabcontroller,
        children: [
//          VideoDetail(),
          Home(),
          Explore(),
          Following(),
        ],
      ),
    );
  }
}
