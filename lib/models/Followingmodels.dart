import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FollowingModel {
  String name;
  Map<String, dynamic> followers;
  Map<String, dynamic> following;
  FollowingModel(
      {String name,
      Map<String, dynamic> followers,
      Map<String, dynamic> following}) {
    this.name = name;
    this.followers = followers;
    this.following = following;
  }
  extractdataFollowing() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    List<Map> allinfo = [];
    List<Map> fol = [];
    for (var i in following.values) {
      if (i != null) {
        var doc = firestore.doc(i);
        var docdata = await doc.get();
        var data = docdata.data();
        allinfo.add({
          'docid': i,
          'dplink': data['DisplayPic'] != null
              ? data['DisplayPic']
              : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
          'followers': data['followers'],
          'following': data['following '],
          'name': data['name'],
        });
        fol.add({data['name']: 'Following'});
      }
    }
    return [allinfo, fol];
  }

  extractdataFollowers() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    List<Map> allinfo = [];
    List<Map> fol = [];
    for (var i in followers.values) {
      if (i != null) {
        var doc = firestore.doc(i);
        var docdata = await doc.get();
        var data = docdata.data();

        allinfo.add({
          'docid': i,
          'followers': data['followers'],
          'following': data['following '],
          'name': data['name'],
        });
        fol.add({data['name']: 'Followers'});
      }
    }
    return [allinfo, fol];
  }
}
