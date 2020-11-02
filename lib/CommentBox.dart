import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp1/models/commentlist.dart';
import 'package:newapp1/services/videos.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

class CommentBox extends StatefulWidget {
  var info;
  CommentBox({this.info}) {}
  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  bool flag = false;

  List<CommentList> commentlist = [];
  void comments() async {
    commentlist = [];
    await Firebase.initializeApp();
    var firebase = FirebaseFirestore.instance;

    var doc2 = firebase.doc('vedioref/YRR4XMHkCVt8LMU3xJQS');

    var data2 = await doc2.get();

    var com = data2.data()[widget.info.key]['commentL'];
    var key = com.keys.toList();
    key.sort();

    for (var i in key.reversed) {
      commentlist.add(CommentList(
          time: i,
          name: com[i]['name'],
          docid: com[i]['docid'],
          comment: com[i]['comment']));
    }
    setState(() {
      flag = true;
      flag2 = true;
    });
  }

  TextEditingController controller = TextEditingController();
  bool flag2 = false;
  @override
  Widget build(BuildContext context) {
    if (!flag) comments();
    if (flag2)
      return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              flag = false;
            });
          },
          child: FlutterEasyLoading(
              child: Scaffold(
            appBar: AppBar(
                title: Text('Comment down'),
                bottom: PreferredSize(
                    preferredSize: Size(100, 100),
                    child: Container(
                        child: Column(children: [
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText:
                              '                       enter the comment here',
                        ),
                      ),
                      FlatButton.icon(
                        onPressed: () async {
                          EasyLoading.show(
                              status: 'Posting',
                              indicator: SpinKitDoubleBounce(
                                color: Colors.blue[300],
                              ));
                          await Videos().setComment(
                              widget.info.key,
                              widget.info.type,
                              controller.text,
                              widget.info.docid);
                          EasyLoading.dismiss();
                          EasyLoading.showSuccess('Comment Posted',
                              duration: Duration(seconds: 1));
                          Toast.show('Posted', context);
                          setState(() {
                            flag = false;
                          });
                        },
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue[300],
                        ),
                        label: Text(
                          'Comment',
                          style: TextStyle(color: Colors.blue[300]),
                        ),
                      )
                    ])))),
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index < commentlist.length)
                      // return Container(
                      //     margin: EdgeInsets.all(10),
                      //     color: Colors.blue[300],
                      //     child: Row(
                      //       children: [
                      //         CircularProfileAvatar(
                      //           'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                      //           radius: 30,
                      //         ),
                      //         SizedBox(width: 40),
                      //         Text('${commentlist[index].name}'),
                      //         SizedBox(width: 30),
                      //         Text('${commentlist[index].comment}'),
                      //       ],
                      //     ));
                      return ListTile(
                        leading: CircularProfileAvatar(
                          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                          radius: 20,
                        ),
                        title: Text('${commentlist[index].name}'),
                        subtitle: Text('${commentlist[index].comment}'),
                      );
                  }),
                )
              ],
            ),
          )));
    else
      return SpinKitDoubleBounce(color: Colors.blue);
  }
}
