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
import 'package:share_extend/share_extend.dart';

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
  String followno = 'Loading...';
  bool flag = false;
  void checklike() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var doc = firestore.doc(pref.getStringList('your info')[3]);
    var docdata = await doc.get();

    var data = docdata.data()['likedvideos'];
    var disdata = docdata.data()['dislikedvideos'];
    if (data != null) if (data.contains(widget.info.key)) {
      iconcolor = Colors.blue[300];
    } else
      iconcolor = Colors.grey[500];
    if (disdata != null) if (disdata.contains(widget.info.key)) {
      iconcolord = Colors.blue[300];
    } else
      iconcolord = Colors.grey[500];
    setState(() {});
  }

  void checkfollow() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(widget.info.docid);
    var docdata = await doc.get();
    var data = docdata.data();
    setState(() {
      followno = docdata.data()['followers'].toString();
      flag2 = true;
    });
  }

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

  void viewchange() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(widget.docid);
    var doc2 = firestore.doc('vedioref/YRR4XMHkCVt8LMU3xJQS');
    DocumentReference doc3;
    if (widget.info.type == "Music")
      doc3 = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/music/tySX14VAbC5kX6JAT4Hw');
    else if (widget.info.type == 'Games')
      doc3 = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/games/4NTKht6v17GYK6QSrW7w');
    else if (widget.info.type == 'Sports')
      doc3 = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/sports/fbZY3bTYA32pQpneB8ue');
    else if (widget.info.type == 'Movies')
      doc3 = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/movies/erhvCRKE2QO6hYQMbc8G');
    else {
      doc3 = firestore.doc('vedioref/0snSkSG1HxVpgTQ1pzjT');
    }
    var docdata = await doc.get();
    var docdata2 = await doc2.get();
    var docdata3 = await doc3.get();
    var views1 = docdata.data()['videos'];
    var views2 = docdata2.data()[widget.info.key];
    var views3 = docdata3.data()[widget.info.key];
    print(widget.info.key);
    views1[widget.info.key]['views']++;
    views2['views']++;
    views3['views']++;
    widget.info.views++;
    doc.update({
      'videos': views1,
    });
    doc2.update({
      widget.info.key: views2,
    });
    doc3.update({
      widget.info.key: views3,
    });
    setState(() {});
  }

  bool flag2 = false;
  void initState() {
    super.initState();
    viewchange();
    checklike();
  }

  @override
  Widget build(BuildContext context) {
    if (!flag2) checkfollow();
    if (!flag) check();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            flickManager.flickControlManager.dispose();
            print('done');
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_left),
        ),
        centerTitle: true,
        title: Text('Videos'),
      ),
      body: ListView(
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
                        '${widget.info.name}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${followno} Followers',
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
                                        pref.getStringList('your info')[3];
                                    this.follows = 'Following';
                                  } else {
                                    m1['followers']--;
                                    m1['followers-name'][m2['name']] = null;
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
                                    m1['following-name'][m2['name']] = null;
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
          // Padding(
          //   padding: const EdgeInsets.only(left: 19, top: 8.0),
          //   child: Container(
          //     child: Text(
          //       'You May Also Like',
          //       textAlign: TextAlign.start,
          //       style: TextStyle(
          //         color: Colors.grey,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
          //   child: _dropDownList(),
          // ),
        ],
      ),
    );
  }

  FlickManager flickManager;

  void dispose() {
    flickManager.flickVideoManager.dispose();
    flickManager.flickControlManager.mute();
    super.dispose();
  }

  Widget _buildVideoPlayer(BuildContext context) {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.info.video),
    );

    return Container(
      child: FlickVideoPlayer(
        flickManager: flickManager,
      ),
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

  Color iconcolor = Colors.grey[500];
  Color iconcolord = Colors.grey[500];
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
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();

                    await Firebase.initializeApp();
                    var firestore = FirebaseFirestore.instance;
                    var doc = firestore.doc(pref.getStringList('your info')[3]);
                    var doc1 = firestore.doc(widget.docid);
                    var doc2 = firestore.doc('vedioref/YRR4XMHkCVt8LMU3xJQS');
                    DocumentReference doc3;
                    if (widget.info.type == "Music")
                      doc3 = firestore.doc(
                          'vedioref/0snSkSG1HxVpgTQ1pzjT/music/tySX14VAbC5kX6JAT4Hw');
                    else if (widget.info.type == 'Games')
                      doc3 = firestore.doc(
                          'vedioref/0snSkSG1HxVpgTQ1pzjT/games/4NTKht6v17GYK6QSrW7w');
                    else if (widget.info.type == 'Sports')
                      doc3 = firestore.doc(
                          'vedioref/0snSkSG1HxVpgTQ1pzjT/sports/fbZY3bTYA32pQpneB8ue');
                    else if (widget.info.type == 'Movies')
                      doc3 = firestore.doc(
                          'vedioref/0snSkSG1HxVpgTQ1pzjT/movies/erhvCRKE2QO6hYQMbc8G');
                    else {
                      doc3 = firestore.doc('vedioref/0snSkSG1HxVpgTQ1pzjT');
                    }
                    var docdatapre = await doc.get();
                    var docdata = await doc1.get();
                    var docdata2 = await doc2.get();
                    var docdata3 = await doc3.get();

                    List likedvideos = docdatapre.data()['likedvideos'];
                    var videos = docdata.data()['videos'];
                    var data = docdata2.data()[widget.info.key];
                    var data2 = docdata3.data()[widget.info.key];
                    if (likedvideos == null) {
                      likedvideos = [];
                    }
                    print('done23');
                    if (likedvideos.contains(widget.info.key)) {
                      videos[widget.info.key]['likes']--;
                      data['likes']--;
                      data2['likes']--;
                      likedvideos.remove(widget.info.key);
                    } else {
                      videos[widget.info.key]['likes']++;
                      data['likes']++;
                      data2['likes']++;
                      likedvideos.add(widget.info.key);
                    }
                    doc.update({
                      'likedvideos': likedvideos,
                    });
                    doc1.update({
                      'videos': videos,
                    });
                    doc2.update({
                      widget.info.key: data,
                    });
                    doc3.update({
                      widget.info.key: data2,
                    });

                    iconcolor = iconcolor == Colors.blue[300]
                        ? Colors.grey[500]
                        : Colors.blue[300];
                    setState(() {});
                  },
                  child: Icon(Icons.thumb_up, color: iconcolor)),
            ),
            Expanded(
                child: FlatButton(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();

                      await Firebase.initializeApp();
                      var firestore = FirebaseFirestore.instance;
                      var doc =
                          firestore.doc(pref.getStringList('your info')[3]);
                      var doc1 = firestore.doc(widget.docid);
                      var doc2 = firestore.doc('vedioref/YRR4XMHkCVt8LMU3xJQS');
                      DocumentReference doc3;
                      if (widget.info.type == "Music")
                        doc3 = firestore.doc(
                            'vedioref/0snSkSG1HxVpgTQ1pzjT/music/tySX14VAbC5kX6JAT4Hw');
                      else if (widget.info.type == 'Games')
                        doc3 = firestore.doc(
                            'vedioref/0snSkSG1HxVpgTQ1pzjT/games/4NTKht6v17GYK6QSrW7w');
                      else if (widget.info.type == 'Sports')
                        doc3 = firestore.doc(
                            'vedioref/0snSkSG1HxVpgTQ1pzjT/sports/fbZY3bTYA32pQpneB8ue');
                      else if (widget.info.type == 'Movies')
                        doc3 = firestore.doc(
                            'vedioref/0snSkSG1HxVpgTQ1pzjT/movies/erhvCRKE2QO6hYQMbc8G');
                      else {
                        doc3 = firestore.doc('vedioref/0snSkSG1HxVpgTQ1pzjT');
                      }
                      var docdatapre = await doc.get();
                      var docdata = await doc1.get();
                      var docdata2 = await doc2.get();
                      var docdata3 = await doc3.get();

                      List dislikedvideos = docdatapre.data()['dislikedvideos'];
                      var videos = docdata.data()['videos'];
                      var data = docdata2.data()[widget.info.key];
                      var data2 = docdata3.data()[widget.info.key];
                      if (dislikedvideos == null) {
                        dislikedvideos = [];
                      }
                      print('done23');
                      if (dislikedvideos.contains(widget.info.key)) {
                        videos[widget.info.key]['dislikes']--;
                        data['dislikes']--;
                        data2['dislikes']--;
                        dislikedvideos.remove(widget.info.key);
                      } else {
                        videos[widget.info.key]['dislikes']++;
                        data['dislikes']++;
                        data2['dislikes']++;
                        dislikedvideos.add(widget.info.key);
                      }
                      doc.update({
                        'dislikedvideos': dislikedvideos,
                      });
                      doc1.update({
                        'videos': videos,
                      });
                      doc2.update({
                        widget.info.key: data,
                      });
                      doc3.update({
                        widget.info.key: data2,
                      });

                      iconcolord = iconcolord == Colors.blue[300]
                          ? Colors.grey[500]
                          : Colors.blue[300];
                      setState(() {});
                    },
                    child: Icon(
                      Icons.thumb_down,
                      color: iconcolord,
                    ))),
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
                    ShareExtend.share(widget.info.video, 'text');
                  },
                  child: Image.asset('assets/images/Group 263.png',
                      height: 44, width: 44)),
            ),
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CommentBox(info:widget.info)));
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

  // Widget _ads() {
  //   return Container(
  //     height: 70,
  //     color: Colors.blue,
  //     child: ListTile(
  //       leading: Container(
  //           height: 40,
  //           width: 50,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: Colors.white54,
  //           )),
  //       title: Text('Advertisement',
  //           style: TextStyle(
  //             fontSize: 18,
  //           )),
  //       subtitle: Text(
  //         'www.site.com',
  //       ),
  //       trailing: Image.asset(
  //         'assets/images/Small Button ad.png',
  //         height: 40,
  //         width: 120,
  //       ),
  //     ),
  //   );
  // }

  // Widget _dropDownList() {
  //   return Container(
  //     height: 300,
  //     color: Colors.white,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(width: 10),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             height: 100,
  //             width: 110,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Container(
  //               child: ListTile(
  //                 title: Text(
  //                   'Video Name , Legthening the Title For the Idea of the Title Placement',
  //                   style: TextStyle(color: Colors.black54, fontSize: 12.0),
  //                 ),
  //                 subtitle: Text(
  //                   '                                                                                                                                            ' +
  //                       '04.08 min' +
  //                       'Channel Name' +
  //                       '    ' +
  //                       '2.7k views',
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
//Image.asset('masxresdefault.jpg'),
}
