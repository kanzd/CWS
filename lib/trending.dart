import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp1/models/homevideoModel.dart';
import 'package:newapp1/services/videos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Video_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class TrendingFeed extends StatefulWidget {
  String type;
  TrendingFeed({type, key}) : super(key: key) {
    this.type = type;
  }
  @override
  _TrendingFeedState createState() => _TrendingFeedState();
}

class _TrendingFeedState extends State<TrendingFeed> {
  List<HomeVideoModel> finallist = [];
  bool flag = false;
  bool len = true;
  var data;
  getvideo() async {
    List<HomeVideoModel> finallist = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = await Videos(docid: pref.getStringList('your info')[3])
        .trending(type: widget.type);
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(pref.getStringList('your info')[3]);
    var docdata = await doc.get();
    this.data = docdata.data()['following-name'];
    print(this.data);
    if (data.keys.toList().length > 0) {
      var keys = data.keys.toList();
      keys.sort();
      print(keys);
      for (var i in keys) {
        print(i);
        finallist.add(HomeVideoModel(
            thumbnail: data[i]['thumbnail'],
            key: i,
            video: data[i]['videouri'],
            title: data[i]['title'],
            docid: data[i]['docid'],
            commentsL: data[i]['commectL'],
            likes: data[i]['likes'],
            dislikes: data[i]['dislikes'],
            length: data[i]['length'],
            views: data[i]['views'],
            comments: data[i]['comments']));

        print(finallist);
        this.finallist = finallist.reversed.toList();
        setState(() {
          flag = true;
        });
      }
    } else {
      len = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!flag) getvideo();
    if (!len)
      return Center(
          child: Text('No Upload on this section',
              style: TextStyle(fontSize: 20)));
    if ((flag) && (len))
      return RefreshIndicator(
        child: ListView.builder(
          itemCount: finallist.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: Container(
                      child: AspectRatio(
                        child: Image.network(
                          finallist[index].thumbnail,
                          loadingBuilder: (context, child, chunk) {
                            if (chunk == null)
                              return child;
                            else
                              return SpinKitDualRing(color: Colors.blue);
                          },
                          centerSlice: Rect.largest,
                        ),
                        aspectRatio: 16 / 9,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoDetail(
                                info: finallist[index],
                               follwerslist: this.data,
                                docid: finallist[index].docid)),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      finallist[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        finallist[index].views.toString() +
                            "    " +
                            finallist[index].length,
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ],
              ),
            );
          },
        ),
        onRefresh: () {
          setState(() {
            flag = false;
          });
        },
      );
    else
      return SpinKitFadingCircle(
        color: Colors.blue,
      );
  }
}
