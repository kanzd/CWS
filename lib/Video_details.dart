import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:newapp1/services/videos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CommentBox.dart';
import 'Gift.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'Channel_Page.dart';
import 'CustomDialouge.dart';

class VideoDetail extends StatefulWidget {
  var info;
  var docid;
  var follwerslist;
  VideoDetail({Key key, this.info, this.docid, this.follwerslist})
      : super(key: key);

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  Color color = Colors.blue;
  String follows = 'Follow';
  bool flag = false;
  void check() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(widget.docid);
    var docdata = await doc.get();
    var data = docdata.data();
    print(widget.follwerslist);
    print('done');
    if (widget.follwerslist[data['name']] != null) {
      print('done');
      setState(() {
        this.follows = 'Following';
        this.color = Colors.blue[900];

        this.flag = true;
      });
    }
  }
  void viewchange() async
  {
    await Firebase.initializeApp();
  
  }
  @override
  Widget build(BuildContext context) {
    if (!flag) check();
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildVideoPlayer(context),
          // Padding(
          //   padding: const EdgeInsets.only(left: 0, top: 0),
          //   child: Row(
          //     children: [
          //       Image.asset('assets/images/Group 22.png',
          //           height: 17, width: 180)
          //     ],
          //   ),
          // ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _videoInfo(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      "${widget.info.title}",
                      style: TextStyle(color: Colors.black54, fontSize: 15.0),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _listIcon(context),
                ),
                _line(),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 70,
                        child: ListTile(
                            leading: Image.asset('assets/images/Profile-1.png'),
                            title: Text(
                              'Channel Name',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              '123k Followers',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            trailing: FlatButton.icon(
                              label: Text(
                                this.follows,
                                style: TextStyle(color: this.color),
                              ),
                              onPressed: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                Videos().updateFollowers(
                                    info: widget.info,
                                    perinfo: pref.getStringList('your info'),
                                    function: (Map m1, Map m2, String value) {
                                      if (value == 'follow') {
                                        if (m1['followers-name'][m2['name']] ==
                                            null) {
                                          m1['followers']++;
                                          m1['followers-name'][m2['name']] =
                                              pref.getStringList(
                                                  'your info')[3];
                                          this.follows = 'Following';
                                        } else {
                                          m1['followers']--;
                                          m1['followers-name'][m2['name']] =
                                              null;
                                          this.follows = 'Follow';
                                        }
                                      } else {
                                        print(m1);
                                        if (m1['following-name'][m2['name']] ==
                                            null) {
                                          m1['following ']++;
                                          m1['following-name'][m2['name']] =
                                              widget.docid;
                                          this.follows = 'Following';
                                        } else {
                                          m1['following ']--;
                                          m1['following-name'][m2['name']] =
                                              null;
                                          this.follows = 'Follow';
                                        }
                                      }
                                      print('done');
                                      setState(() {});
                                      return m1;
                                    });
                              },
                              icon: Icon(Icons.verified_user),
                            ))),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Channel()),
                    );
                  },
                ),
                _ads(),
                Padding(
                  padding: const EdgeInsets.only(left: 19, top: 8.0),
                  child: Container(
                    child: Text(
                      'You May Also Like',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                  child: _dropDownList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  var flickManager;
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer(BuildContext context) {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.info.video),
    );
    return Container(
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }

//   return Container(
//     margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//     width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).orientation == Orientation.portrait
//         ? 200.0
//         : MediaQuery.of(context).size.height -
//             MediaQuery.of(context).padding.top,
//     decoration: BoxDecoration(
//         image: DecorationImage(
//       image: NetworkImage(
//         'https://i.ytimg.com/vi/sPW7nDBqt8w/maxresdefault.jpg',
//       ),
//       fit: BoxFit.fill,
//     )),
//     child: Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Image.asset(
//             'assets/images/Union 4.png',
//             height: 20,
//             width: 20,
//           ),
//           SizedBox(width: 20),
//           Image.asset(
//             'assets/images/Symbol 7 – 1.png',
//             height: 80,
//             width: 80,
//           ),
//           SizedBox(width: 20),
//           Image.asset(
//             'assets/images/Union 3.png',
//             height: 20,
//             width: 20,
//           ),
//         ],
//       ),
//     ),
//   );
// }

  Widget _videoInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        child: ListTile(
          leading: Text(
            '${widget.info.views} Views',
            textAlign: TextAlign.start,
          ),
          trailing: Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }

  Widget _listIcon(context) {
    Color _iconColor = Colors.transparent;
    return Expanded(
      child: Container(
        width: 200,
        padding: EdgeInsets.only(top: 10, left: 0.0, bottom: 5.0, right: 20),
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                color: _iconColor,
                onPressed: () {
                  _iconColor = Colors.blue;
                  print('1');
                },
                child: Image.asset('assets/images/Component 1 – 1 1.png',
                    height: 40, width: 40),
              ),
            ),
            Expanded(
              child: FlatButton(
                  onPressed: () {},
                  child: Image.asset('assets/images/Component 2 – 1.png',
                      height: 45, width: 45)),
            ),
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GiftPop()),
                    );
                  },
                  child: Image.asset('assets/images/Group 264.png',
                      height: 44, width: 44)),
            ),
            Expanded(
              child: FlatButton(
                  color: ExitConfirmationDialog() != null
                      ? Colors.transparent
                      : Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExitConfirmationDialog()),
                    );
                  },
                  child: Image.asset('assets/images/Group 263.png',
                      height: 44, width: 44)),
            ),
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CommentBox()));
                  },
                  child: Image.asset('assets/images/Group 262.png',
                      height: 44, width: 44)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 1.0,
      width: 130.0,
      color: Colors.grey,
    );
  }

  Widget _ads() {
    return Container(
      height: 70,
      color: Colors.blue,
      child: ListTile(
        leading: Container(
            height: 40,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white54,
            )),
        title: Text('Advertisement',
            style: TextStyle(
              fontSize: 18,
            )),
        subtitle: Text(
          'www.site.com',
        ),
        trailing: Image.asset(
          'assets/images/Small Button ad.png',
          height: 40,
          width: 120,
        ),
      ),
    );
  }

  Widget _dropDownList() {
    return Container(
      height: 300,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ListTile(
                  title: Text(
                    'Video Name , Legthening the Title For the Idea of the Title Placement',
                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                  ),
                  subtitle: Text(
                    '                                                                                                                                            ' +
                        '04.08 min' +
                        'Channel Name' +
                        '    ' +
                        '2.7k views',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
//Image.asset('masxresdefault.jpg'),
}
