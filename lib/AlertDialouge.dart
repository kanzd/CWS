import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  static final homePageKey = GlobalKey<TabsState>();
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
      body: new TabBar(
        controller: tabcontroller,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Color(0xFFFFFFFF),
        tabs: const <Tab>[
          const Tab(text: 'Tranding'),
          const Tab(text: 'Men'),
          const Tab(text: 'Women'),
        ],
      ),
    );
  }
}
