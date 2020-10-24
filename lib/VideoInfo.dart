import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp1/models/homevideoModel.dart';
import 'package:newapp1/services/videos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Video_details.dart';

// class VideoFeed extends StatefulWidget {
//   VideoFeed({Key key}) : super(key: key);

//   _VideoFeedState createState() => _VideoFeedState();
// }

// class _VideoFeedState extends State<VideoFeed> {
//   List<Map> data = [
//     {
//       'url': 'https://www.youtube.com/watch?v=3R6KnQLvZNI',
//       'thumbnail': 'https://i.ytimg.com/vi/sPW7nDBqt8w/maxresdefault.jpg',
//       'title':
//           'Video Name, Lengthening the Title for the Idea of the Title Placement',
//       'date': ' 2k views',
//       'creator': 'Channel Name',
//     },
//     {
//       'url': 'https://www.youtube.com/watch?v=3R6KnQLvZNI',
//       'thumbnail': 'https://i.ytimg.com/vi/sPW7nDBqt8w/maxresdefault.jpg',
//       'title':
//           'Video Name, Lengthening the Title for the Idea of the Title Placement',
//       'date': ' 2k views',
//       'creator': 'Channel Name',
//       'profile_url':
//           'https://yt3.ggpht.com/a/AGF-l7-GpYFwHDMQVXkOcO3Ra8bIoZhhiU3oluiJBw=s88-mo-c-c0xffffffff-rj-k-no',
//     },
//     {
//       'url': 'https://www.youtube.com/watch?v=3R6KnQLvZNI',
//       'thumbnail': 'https://i.ytimg.com/vi/sPW7nDBqt8w/maxresdefault.jpg',
//       'title':
//           'Video Name, Lengthening the Title for the Idea of the Title Placement',
//       'date': ' 2k views',
//       'creator': 'Channel Name',
//     },
//     {
//       'url': 'https://www.youtube.com/watch?v=3R6KnQLvZNI',
//       'thumbnail': 'https://i.ytimg.com/vi/sPW7nDBqt8w/maxresdefault.jpg',
//       'title':
//           'Video Name, Lengthening the Title for the Idea of the Title Placement',
//       'date': ' 2k views',
//       'creator': 'Channel Name',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: data.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           child: Column(
//             children: <Widget>[
//               InkWell(
//                 child: Container(
//                   child: AspectRatio(
//                     child: Image(
//                       image: NetworkImage(data[index]['thumbnail']),
//                       centerSlice: Rect.largest,
//                     ),
//                     aspectRatio: 16 / 9,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => VideoDetail()),
//                   );
//                 },
//               ),
//               ListTile(
// //
//                 title: Text(
//                   da].title,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle:
//                     Text(data[index]['creator'] + "    " + data[index]['date'],
//                         style: TextStyle(
//                           color: Colors.grey,
//                         )),
//               ),
//               Container(
//                 height: 80,
//                 color: Colors.blue,
//                 child: ListTile(
//                   leading: Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white54,
//                       )),
//                   title: Text('Advertisement',
//                       style: TextStyle(
//                         fontSize: 23,
//                       )),
//                   subtitle: Text(
//                     'www.site.com',
//                   ),
//                   trailing: Image.asset('assets/images/Small Button ad.png',
//                       height: 40),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
class VideoFeed extends StatefulWidget {
  @override
  _VideoFeedState createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {
  List<HomeVideoModel> finallist = [];
  bool flag = false;
  var data;
  getvideo() async {
    List<HomeVideoModel> finallist = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    this.data = pref.getStringList('your info');
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(pref.getStringList('your info')[3]);
    var docdata = await doc.get();
    this.data = docdata.data()['following-name'];
    print(this.data);
    var data = await Videos(docid: pref.getStringList('your info')[3])
        .getFollowedVideos();
    if (data[0]) {
      int count = 0;
      for (var i in data[1]) {
        
        print(i);
        finallist.add(HomeVideoModel(
          title: i['title'],
          thumbnail: i['thumbnail'],
          key: data[2][count],
          follows: i['following-name'],
          commentsL: i['commectL'],
          comments: i['comments'],
          docid: i['docid'],
          name:i['user'],
          likes: i['likes'],
          type: i['type'],
          dislikes: i['dislikes'],
          length: i['length'],
          video: i['videouri'],
          views: i['views'],
        ));
        count++;

      }
    } else {
      var keys = data[1].keys.toList();
      keys.sort();
      print(keys);
      for (var i in keys) {
        print(i);
        finallist.add(HomeVideoModel(
            thumbnail: data[1][i]['thumbnail'],
            video: data[1][i]['videouri'],
            key: i,
            name:data[1][i]['user'],
            type: data[1][i]['type'],
            title: data[1][i]['title'],
            follows: data[1][i]['following-name'],
            docid: data[1][i]['docid'],
            commentsL: data[1][i]['commectL'],
            likes: data[1][i]['likes'],
            dislikes: data[1][i]['dislikes'],
            length: data[1][i]['length'],
            views: data[1][i]['views'],
            comments: data[1][i]['comments']));
      }
    }
    print(finallist);
    this.finallist = finallist.reversed.toList();
    setState(() {
      flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!flag) getvideo();
    if (flag)
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
