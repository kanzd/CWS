import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class GiftService {
  String docid;
  int giftamount;
  GiftService({docid, giftamount}) {
    this.docid = docid;
    this.giftamount = giftamount;
  }
  sendGift() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc('revenues/UUhNOuvn0pfVIKb924Ac');
    var docdata = await doc.get();
    var data = docdata.data()[this.docid.split('/')[1]];
    if (data == null) data = {'balance': 0, 'history': {}};

    data['balance'] =data['balance']+ this.giftamount;
    data['history'][pref.getStringList('your info')[3].split('/')[1] +
        ',' +
        DateTime.now().toString()] = this.giftamount;
    var data2 = docdata.data()[pref.getStringList('your info')[3].split('/')[1]];
    if (data2 == null) data2 = {'balance': 0, 'history': {}};
    data2['balance'] =data2['balance']- this.giftamount;
    data2['history'][this.docid.split('/')[1] + ',' + DateTime.now().toString()] =
        -this.giftamount;

    doc.update({
      this.docid.split('/')[1]: data,
      pref.getStringList('your info')[3].split('/')[1]: data2,
    });
  }

  getvals() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc('revenues/UUhNOuvn0pfVIKb924Ac');
    var docdata = await doc.get();
    var data = docdata.data()[pref.getStringList('your info')[3].split('/')[1]];
    if (data == null) data = {'balance': 0, 'history': {}};
    return data;
  }
}
