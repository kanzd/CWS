import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp1/trending.dart';

class Explore extends StatefulWidget {
  Explore({Key key}) : super(key: key);

  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String type = 'Music';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Trending"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            type = 'Music';
                          });
                        },
                        child: Image.asset(
                          'assets/images/Group 268.png',
                          height: 80,
                          width: 120,
                        ),
                      ),
                      SizedBox(width: 10),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              type = 'Sports';
                              print('ee');
                            });
                          },
                          child: Image.asset(
                            'assets/images/Group 269.png',
                            height: 80,
                            width: 120,
                          )),
                      SizedBox(width: 10),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              type = 'Games';
                            });
                          },
                          child: Image.asset(
                            'assets/images/Group 270.png',
                            height: 80,
                            width: 120,
                          )),
                      SizedBox(width: 10),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              type = 'Movies';
                            });
                          },
                          child: Image.asset(
                            'assets/images/Group 271.png',
                            height: 80,
                            width: 120,
                          )),
                    ]),
              ),
            ),
            Expanded(
                child: TrendingFeed(
                  key:GlobalKey(),
              type: this.type,
            )),
          ],
        ),
      ),
    );
  }
}
