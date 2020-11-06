import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment {
  int amount;
  Razorpay razorpay = Razorpay();

  Payment({this.amount});

  pay() {
    var options = {
      'key': 'rzp_test_UW0xGyggIv3JZR',
      'amount': this.amount*500,
      'name': 'something',
      'description': 'something',
      'prefill': {'contact': '+91839283293', 'email': 'Enter your Email'}
    };
    razorpay.open(options);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) async {
      await Firebase.initializeApp();
      SharedPreferences pref = await SharedPreferences.getInstance();
      var firestore = FirebaseFirestore.instance;
      var doc = firestore.doc('revenues/UUhNOuvn0pfVIKb924Ac');
      var docdata = await doc.get();
      var data =
          docdata.data()[pref.getStringList('your info')[3].split('/')[1]];
      data['balance'] = data['balance'] + this.amount;
      data['history'][DateTime.now().toString()] = this.amount;
      doc.update({
        pref.getStringList('your info')[3].split('/')[1]: data,
      });
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      print('false');
    });
  }
}
