import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp1/models/Newuploadmodel.dart';
import 'package:newapp1/services/videos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Video_details.dart';
// class AllVideos extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _buildChild(context);
//   }

//   _buildChild(BuildContext context) => Expanded(
//         child: Container(
//           height: 150,
//           width: 150,
//           color: Colors.white,
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 100,
//                         width: 180,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(
//                             'Video Name , Lengthing The Title for the idea of thr title placement',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 105),
//                             child: Text(
//                               '04.08 min',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 105),
//                             child: Text(
//                               'channel Name   27k views',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 100,
//                         width: 180,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(
//                             'Video Name , Lengthing The Title for the idea of thr title placement',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 105),
//                             child: Text(
//                               '04.08 min',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 105),
//                             child: Text(
//                               'channel Name   27k views',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 100,
//                         width: 180,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(
//                             'Video Name , Lengthing The Title for the idea of thr title placement',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 105),
//                             child: Text(
//                               '04.08 min',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 105),
//                             child: Text(
//                               'channel Name   27k views',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }
class AllVideos extends StatefulWidget {
  @override
  _AllVideosState createState() => _AllVideosState();
}

class _AllVideosState extends State<AllVideos> {
 List<NewuploadModel> videolist = [];
  bool flag = false;
  var data;
  void getlist() async {
    List<NewuploadModel> list1 = [];
    SharedPreferences pref = await SharedPreferences.getInstance();

    var list =
        await Videos(docid: pref.getStringList('your info')[3]).getVideo();
    print(list);
    List tempio = list.keys.toList();
    tempio.sort();
    await Firebase.initializeApp();
    var firestore= FirebaseFirestore.instance;
    var doc = firestore.doc(pref.getStringList('your info')[3]);
    var docdata = await doc.get();
    this.data = docdata.data()['following-name'];
    for (var i in tempio) {
      print(i);
      list1.add(NewuploadModel(
          thumbnail: list[i]['thumbnail'],
          key:i,
          video: list[i]['videouri'],
          title: list[i]['title'],
          commentlist: list[i]['commectL'],
          name: list[i]['user'],
          type:list[i]['type'],
          hashtag: list[i]['hashtag'],
          likes: list[i]['likes'],
          docid:list[i]['docid'],
          dislikes: list[i]['dislikes'],
          length: list[i]['length'],
          views: list[i]['views'],
          comments: list[i]['comments']));
    }

    setState(() {
      if (list.length != videolist.length) videolist = list1;
      flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!flag) {
      getlist();
      return SpinKitDoubleBounce(
        color: Colors.blue,
      );
    }
    if (videolist.length == 0)
      return Center(
          child: Text(
        'No Uploads till now',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ));
    return  RefreshIndicator(
      onRefresh: (){
         flag = false;
          setState(() {});
      },
        child:CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, int index) {
            if (index < videolist.length) {
              return FlatButton(onPressed: (){
                    Navigator.pop(context);
                    Navigator.push(context,  MaterialPageRoute(
                            builder: (context) => VideoDetail(
                                info: videolist[index],
                                follwerslist: this.data,
                                docid: videolist[index].docid)));
                  },child:Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        width: 180,
                        child: Image.network(
                          videolist[index].thumbnail,
                          loadingBuilder: (context, child, chunk) {
                            if (chunk == null)
                              return child;
                            else
                              return SpinKitDualRing(color: Colors.blue);
                          },
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '${videolist[index].title}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 105),
                            child: Text(
                              '${videolist[index].length} ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 105),
                            child: Text(
                              '''channel Name   
                              ${videolist[index].views} views''',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
            } else
              return Text('');
          }),
        ),
      ],
    ));
  }
}