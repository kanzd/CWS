import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Videos {
  String title;
  String docid = '';
  String user;
  String thumbnail;
  String video;
  Videos(
      {this.title, this.docid = '', this.user, this.thumbnail, this.video}) {}
  uploadVideo(
      {String hashtag,
      file,
      String title,
      DateTime time,
      File thumbnail,
      length,
      String docid,
      String type}) async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc('vedioref/YRR4XMHkCVt8LMU3xJQS');
    var ser = firestore.doc('vedioref/9pUTQ0wJ73BvR07yHwob');
    var doc2 = firestore.doc(this.docid);
    var docdata = await doc.get();
    var doc2data = await doc2.get();
    var docser = await ser.get();

    var storage =
        FirebaseStorage.instance.ref().child('video/$title${time.toString()}');
    var thumbnails = FirebaseStorage.instance
        .ref()
        .child('thumbnail/$title${time.toString()}');

    var upload =
        storage.putFile(file, StorageMetadata(contentType: 'video/mp4'));
    var upload2 = thumbnails.putFile(thumbnail);

    var uploadref = await upload.onComplete;
    var uploadref2 = await upload2.onComplete;

    await doc.update({
      time.toString().split('.')[0]: {
        'videouri': await uploadref.ref.getDownloadURL(),
        'thumbnail': await uploadref2.ref.getDownloadURL(),
        'user': doc2data.data()['name'],
        'likes': 0,
        'title': title,
        'hashtag': hashtag,
        'dislikes': 0,
        'comments': 0,
        'views': 0,
        'type': type,
        'length': length,
        'docid': docid,
        'commentL': {},
      }
    });
    var videos = doc2data.data()['videos'];
    videos[time.toString().split('.')[0]] = {
      'thumbnail': await uploadref2.ref.getDownloadURL(),
      'videouri': await uploadref.ref.getDownloadURL(),
      'likes': 0,
      'dislikes': 0,
      'hashtag': hashtag,
      'title': title,
      'user': doc2data.data()['name'],
      'comments': 0,
      'views': 0,
      'type': type,
      'docid': docid,
      'length': length,
      'commectL': {},
    };
    uploadByType(
      hashtag: hashtag,
      title: title,
      thumbnail: await uploadref2.ref.getDownloadURL(),
      video: await uploadref.ref.getDownloadURL(),
      time: time,
      length: length,
      name: doc2data.data()['name'],
      docid: docid,
      type: type,
    );
    await doc2.update({
      'videos': videos,
    });
    var ls = docser.data()[title];
    if (ls == null) {
      ls = [];
    }
    ls.add(time.toString().split('.')[0]);
    await ser.update({
      title: ls,
    });
  }

  uploadByType(
      {String hashtag,
      String title,
      DateTime time,
      thumbnail,
      video,
      String name,
      length,
      String docid,
      String type}) async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    DocumentReference doc;
    if (type == "Music")
      doc = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/music/tySX14VAbC5kX6JAT4Hw');
    else if (type == 'Games')
      doc = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/games/4NTKht6v17GYK6QSrW7w');
    else if (type == 'Sports')
      doc = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/sports/fbZY3bTYA32pQpneB8ue');
    else if (type == 'Movies')
      doc = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/movies/erhvCRKE2QO6hYQMbc8G');
    else {
      doc = firestore.doc('vedioref/0snSkSG1HxVpgTQ1pzjT');
    }
    doc.update({
      time.toString().split('.')[0]: {
        'thumbnail': thumbnail,
        'videouri': video,
        'likes': 0,
        'dislikes': 0,
        'hashtag': hashtag,
        'title': title,
        'user': name,
        'comments': 0,
        'views': 0,
        'type': type,
        'docid': docid,
        'length': length,
        'commectL': {},
      }
    });
  }

  trending({type = 'music'}) async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    DocumentReference doc;
    if (type == "Music")
      doc = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/music/tySX14VAbC5kX6JAT4Hw');
    else if (type == 'Games')
      doc = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/games/4NTKht6v17GYK6QSrW7w');
    else if (type == 'Sports')
      doc = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/sports/fbZY3bTYA32pQpneB8ue');
    else if (type == 'Movies')
      doc = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/movies/erhvCRKE2QO6hYQMbc8G');
    else {
      doc = firestore.doc('vedioref/0snSkSG1HxVpgTQ1pzjT');
    }
    var data = await doc.get();
    return data.data();
  }

  getVideo([docid]) async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc;
    if (docid != null)
      doc = firestore.doc(docid);
    else
      doc = firestore.doc(this.docid);
    var data = await doc.get();
    return data.data()['videos'];
  }

  getFollowedVideos() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(docid);
    var data = await doc.get();
    Map datamap = data.data()['following-name'];
    Map allVids = {};
    if (datamap.keys.toList().length != 0) {
      for (var i in datamap.keys.toList()) {
        allVids[i] = await getVideo(datamap[i]);
      }
      List videos = [];
      Map temp = {};
      for (var i in allVids.keys.toList()) {
        temp.addAll(allVids[i]);
      }
      var ls = temp.keys.toList();
      ls.sort();
      for (var i in ls) {
        videos.add(temp[i]);
      }
      return [true, videos, ls];
    } else {
      doc = firestore.doc('vedioref/YRR4XMHkCVt8LMU3xJQS');
      var data = await doc.get();
      print(data.data());
      return [false, data.data()];
    }
  }

  updateFollowers({info, perinfo, Function(Map, Map, String) function}) async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(info.docid);
    var doc2 = firestore.doc(perinfo[3]);

    var docdata = await doc.get();
    var docdata2 = await doc2.get();
    var data = docdata.data();
    var data2 = docdata2.data();
    print(docdata2.data()['following']);
    print(perinfo[3]);
    data = function(data, data2, 'follow');
    data2 = function(data2, data, 'following');

    doc.update({
      'followers': data['followers'],
      'followers-name': data['followers-name'],
    });
    doc2.update({
      'following ': data2['following '],
      'following-name': data2['following-name'],
    });
    print(data);
    print(data2);
  }

  updateValue({info, likes = false, dislikes = false, comments = false}) async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc;
    if (docid != null)
      doc = firestore.doc(info.docid);
    else
      doc = firestore.doc(this.docid);
    var doc2 = firestore.doc('vedioref/YRR4XMHkCVt8LMU3xJQS');
    var docdata = await doc2.get();
    var data = docdata.data()[info.key];
    if (likes) data['likes']++;
    if (dislikes) data['diskes']++;
    if (comments) data['comments']++;
    data['views']++;
    var docdata2 = await doc.get();
    var data2 = docdata2.data();
    if (likes) data2['videos'][info.key]['likes']++;
    if (dislikes) data2['videos'][info.key]['likes']++;
    if (comments) data2['videos'][info.key]['comments']++;
    doc2.update({
      info.key: data,
    });
    doc.update({info.key: data2});
  }

  getFollwersList() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(this.docid);
    var docdata = await doc.get();
    var data = docdata.data();
    return {
      'followers': data['followers-name'],
      'following': data['following-name']
    };
  }

  setComment(key, type, comment, [docid]) async {
    await Firebase.initializeApp();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(docid != null ? docid : this.docid);
    var doc2 = firestore.doc('vedioref/YRR4XMHkCVt8LMU3xJQS');
    DocumentReference doc3;
    if (type == "Music")
      doc3 = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/music/tySX14VAbC5kX6JAT4Hw');
    else if (type == 'Games')
      doc3 = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/games/4NTKht6v17GYK6QSrW7w');
    else if (type == 'Sports')
      doc3 = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/sports/fbZY3bTYA32pQpneB8ue');
    else if (type == 'Movies')
      doc3 = firestore
          .doc('vedioref/0snSkSG1HxVpgTQ1pzjT/movies/erhvCRKE2QO6hYQMbc8G');
    else {
      doc3 = firestore.doc('vedioref/0snSkSG1HxVpgTQ1pzjT');
    }
    var data = await doc.get();
    var data2 = await doc2.get();
    var data3 = await doc3.get();
    var tempdoc =  firestore.doc(pref.getStringList('your info')[3]);
    var docda = await tempdoc.get();

    var finald1 = data.data()['videos'];
    var finald2 = data2.data()[key];
    var finald3 = data3.data()[key];

    String date = DateTime.now().toString().split('.')[0];
    finald1[key]['commectL'][date] = {
      'name': docda.data()['name'],
      'comment': comment,
      'docid': pref.getStringList('your info')[3],
    };
    finald2['commentL'][date] = {
      'name': docda.data()['name'],
      'comment': comment,
      'docid': pref.getStringList('your info')[3],
    };
    finald3['commectL'][date] = {
      'name': docda.data()['name'],
      'comment': comment,
      'docid': pref.getStringList('your info')[3],
    };
    await doc.update({
      'videos': finald1,
    });
    await doc2.update({
      key: finald2,
    });
    await doc3.update({
      key: finald3,
    });
  }

  getData([docid]) async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc;

    if (docid != null) {
      doc = firestore.doc(docid);
    } else
      doc = firestore.doc(this.docid);

    var data = await doc.get();
    return data.data();
  }
}
