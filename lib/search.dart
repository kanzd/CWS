import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp1/models/homevideoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Video_details.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool loading = false;
  bool find = false;
  String value;
  bool notfound = false;

  var data;
  void fun() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(pref.getStringList('your info')[3]);
    var docdata = await doc.get();
    this.data = docdata.data()['following-name'];
    ok = false;
  }

  bool ok = false;
  List<HomeVideoModel> result = [];
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (ok) fun();
    if (notfound)
      return Scaffold(
          body: Center(
        child: Text(
          "NOT FOUND!!",
          style: TextStyle(
              color: Colors.blue[900],
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
      ));
    if (!find)
      return Scaffold(
        backgroundColor: Colors.blue[300],
        body: !loading
            ? Center(
                child: Container(
                margin: EdgeInsets.all(40),
                child: TextField(
                  onEditingComplete: () async {
                    setState(() {
                      loading = true;
                    });
                    await Firebase.initializeApp();
                    var firestore = FirebaseFirestore.instance;
                    var doc = firestore.doc('vedioref/9pUTQ0wJ73BvR07yHwob');
                    var doc2 = firestore.doc('vedioref/YRR4XMHkCVt8LMU3xJQS');

                    var docdata = await doc.get();
                    var docdata2 = await doc2.get();
                    if (docdata.data()[controller.text] != null) {
                      value = controller.text;
                      for (var i in docdata.data()[controller.text])
                        result.add(HomeVideoModel(
                            thumbnail: docdata2.data()[i]['thumbnail'],
                            video: docdata2.data()[i]['videouri'],
                            key: i,
                            name: docdata2.data()[i]['user'],
                            type: docdata2.data()[i]['type'],
                            title: docdata2.data()[i]['title'],
                            docid: docdata2.data()[i]['docid'],
                            commentsL: docdata2.data()[i]['commentL'],
                            likes: docdata2.data()[i]['likes'],
                            dislikes: docdata2.data()[i]['dislikes'],
                            length: docdata2.data()[i]['length'],
                            views: docdata2.data()[i]['views'],
                            comments: docdata2.data()[i]['comments']));

                      setState(() {
                        find = true;
                      });
                    } else
                      setState(() {
                        notfound = true;
                      });
                  },
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      hintText: 'Search',
                      icon: Icon(Icons.search)),
                ),
              ))
            : SpinKitDoubleBounce(
                color: Colors.yellow,
              ),
      );
    else {
      return Scaffold(
          backgroundColor: Colors.blue[300],
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                expandedHeight: 100.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(value),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index < result.length)
                    return ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoDetail(
                                  info: result[index],
                                  follwerslist: this.data,
                                  docid: result[index].docid),
                            ));
                      },
                      leading: CircularProfileAvatar(result[index].thumbnail),
                      title: Text(result[index].title),
                      subtitle: Text('Click Here to Watch'),
                    );
                }),
              )
            ],
          ));
    }
  }
}
