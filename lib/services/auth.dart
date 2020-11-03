import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Auth {
  String email;
  String name;
  String mobile;
  String passcode;
  Auth({mobile, name, email, passcode}) {
    this.email = email;
    this.passcode = passcode;
    this.mobile = mobile;
    this.name = name;
  }

  Future<dynamic> signup() async {
    await Firebase.initializeApp();
    try {
      var firestore = FirebaseFirestore.instance;
      var doc = firestore.doc('user/3eegwiaV0kADBBbCzcmd');
      var doc2 = firestore.doc('channel-name/yMmX4Y3jKLthGC7tb07s');
      var data = await doc2.get();
      var collection = firestore.collection('videos');
      var ref = await collection.add({
        'name': this.name,
        'followers': 0,
        'following ': 0,
        'followers-name': {},
        'following-name': {},
        'videos': {},
      });
      doc.update({
        this.email.split('.')[0]: {
          'name': this.name,
          'number': mobile,
          'passcode': this.passcode,
          'videos-ref': ref.path,
        }
      });
      if (!data.data().containsKey(this.name)) {
        doc2.update({
          this.name: ref.path,
        });
      } else {
        throw FirebaseAuthException(
            message: 'Name Already Exist', code: 'Name Already Exist');
      }

      var auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: this.email, password: this.passcode);
      return [true, auth];
    } on FirebaseAuthException catch (e) {
      return [false, e];
    }
  }

  sendcode() async {
    await Firebase.initializeApp();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var auth = FirebaseAuth.instance;

    await auth.sendPasswordResetEmail(
        email: pref.getStringList('your info')[1]);
    return true;
  }

  // facebookauth() async {
  //   await Firebase.initializeApp();
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var fauth = FacebookAuth.instance;
  //   var result = await fauth.login();
  //   var cred = FacebookAuthProvider.credential(result.accessToken.token);
  //   var auth = await FirebaseAuth.instance.signInWithCredential(cred);
  //   if (auth != null) {
  //     var firestore = FirebaseFirestore.instance;
  //     var doc = firestore.doc('user/3eegwiaV0kADBBbCzcmd');
  //     var doc2 = firestore.doc('channel-name/yMmX4Y3jKLthGC7tb07s');
  //     var data = await doc2.get();
  //     var collection = firestore.collection('videos');
  //     var ref;
  //     if (data.data()[auth.user.email.split('.')[0]] == null) {
  //       var ref = await collection.add({
  //         'name': auth.user.displayName,
  //         'followers': 0,
  //         'following ': 0,
  //         'followers-name': {},
  //         'following-name': {},
  //         'videos': {},
  //       });
  //       doc.update({
  //         auth.user.email.split('.')[0]: {
  //           'name': auth.user.displayName,
  //           'number': auth.user.phoneNumber,
  //           'videos-ref': ref.path,
  //         }
  //       });
  //       if (!data.data().containsKey(auth.user.displayName)) {
  //         doc2.update({
  //           auth.user.displayName: ref.path,
  //         });
  //       }
  //     }
  //     await pref.setBool('auth', true);
  //     await pref.setStringList('your info', [
  //       auth.user.displayName,
  //       auth.user.email,
  //       auth.user.phoneNumber,
  //       ref!=null?ref.path:data[auth.user.displayName],
  //     ]);
  //   }
  // }

  comfirm({code, newpasscode}) async {
    await Firebase.initializeApp();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var auth = FirebaseAuth.instance;
    await auth.confirmPasswordReset(code: code, newPassword: newpasscode);
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc('user/3eegwiaV0kADBBbCzcmd');
    var docdata = await doc.get();
    var data = docdata.data()[pref.getStringList('your info')[1].split('.')[0]];
    data['passcode'] = newpasscode;
    doc.update({
      pref.getStringList('your info')[1].split('.')[0]: data,
    });

    return true;
  }

  Future<dynamic> login() async {
    await Firebase.initializeApp();
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      var auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: this.email, password: this.passcode);
      var firestore = FirebaseFirestore.instance;
      var doc = firestore.doc('user/3eegwiaV0kADBBbCzcmd');
      var docdata = await doc.get();
      await pref.setBool('auth', true);
      await pref.setStringList('your info', [
        this.name,
        this.email,
        this.mobile,
        docdata[this.email.split('.')[0]]['videos-ref']
      ]);
      return [true, auth];
    } on FirebaseAuthException catch (e) {
      return [false, e];
    }
  }
}
