import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp1/services/fileselect.dart';
import 'package:newapp1/services/videos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:toast/toast.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var userinfo;
  void getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    var doc = firestore.doc('/user/3eegwiaV0kADBBbCzcmd');
    var docdata = await doc.get();
    userinfo = docdata.data()[pref.getStringList('your info')[1].split('.')[0]];
    userinfo['email'] = pref.getStringList('your info')[1];
    doc = firestore.doc(pref.getStringList('your info')[3]);
    docdata = await doc.get();
    if(docdata.data()['DisplayPic']!=null)
    dplink = docdata.data()['DisplayPic'];
    
    setState(() {
      val = true;
    });
  }

  String dplink =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
  bool dpupload = false;
  bool val = false;
  @override
  Widget build(BuildContext context) {
    if (dpupload)
      return Scaffold(
        body: SpinKitFoldingCube(
          color: Colors.blue,
        ),
      );
    getdata();
    if (val)
      return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          centerTitle: true,
        ),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 50),
            decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(60)),
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                ListTile(
                  title: Text('Name'),
                  subtitle: Text('${userinfo['name']}'),
                  leading: Icon(Icons.info),
                ),
                ListTile(
                  title: Text("Email"),
                  subtitle: Text('${userinfo['email']}'),
                  leading: Icon(Icons.email),
                ),
                ListTile(
                    title: Text('Phone No.'),
                    subtitle: Text('${userinfo['number']}'),
                    leading: Icon(Icons.phone)),
                FlatButton.icon(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Form'),
                              content: ListView(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text('Camera'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      setState(() {
                                        dpupload = true;
                                      });
                                      Image_Service image_service =
                                          Image_Service(selecttype: 'camera');
                                      File pic = await image_service.image();
                                      var crop = await ImageCropper.cropImage(
                                          sourcePath: pic.path,
                                          aspectRatioPresets: [
                                            CropAspectRatioPreset.square,
                                            CropAspectRatioPreset.ratio3x2,
                                            CropAspectRatioPreset.original,
                                            CropAspectRatioPreset.ratio4x3,
                                            CropAspectRatioPreset.ratio16x9
                                          ],
                                          androidUiSettings: AndroidUiSettings(
                                              toolbarTitle: 'Cropper',
                                              toolbarColor: Colors.blue[300],
                                              toolbarWidgetColor: Colors.white,
                                              initAspectRatio:
                                                  CropAspectRatioPreset
                                                      .original,
                                              lockAspectRatio: false),
                                          iosUiSettings: IOSUiSettings(
                                            minimumAspectRatio: 1.0,
                                          ));
                                      var upload = await Videos().changeDp(
                                          crop,
                                          userinfo['email'],
                                          userinfo['videos-ref']);
                                      setState(() {
                                        dpupload = false;
                                        dplink = upload;
                                      });

                                      Toast.show(
                                          'Profile pic updated', context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text('Gallery'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      setState(() {
                                        dpupload = true;
                                      });
                                      Image_Service image_service =
                                          Image_Service(selecttype:'gallery');
                                      File pic = await image_service.image();
                                      var crop = await ImageCropper.cropImage(
                                          sourcePath: pic.path,
                                          aspectRatioPresets: [
                                            CropAspectRatioPreset.square,
                                            CropAspectRatioPreset.ratio3x2,
                                            CropAspectRatioPreset.original,
                                            CropAspectRatioPreset.ratio4x3,
                                            CropAspectRatioPreset.ratio16x9
                                          ],
                                          androidUiSettings: AndroidUiSettings(
                                              toolbarTitle: 'Cropper',
                                              toolbarColor: Colors.blue[300],
                                              toolbarWidgetColor: Colors.white,
                                              initAspectRatio:
                                                  CropAspectRatioPreset
                                                      .original,
                                              lockAspectRatio: false),
                                          iosUiSettings: IOSUiSettings(
                                            minimumAspectRatio: 1.0,
                                          ));
                                      var upload = await Videos().changeDp(
                                          crop,
                                          userinfo['email'],
                                          userinfo['videos-ref']);
                                      setState(() {
                                        dpupload = false;
                                        dplink = upload;
                                      });

                                      Toast.show(
                                          'Profile pic updated', context);
                                    },
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    icon: Icon(Icons.image),
                    label: Text('change Dp')),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 90, top: 10),
              child: CircularProfileAvatar(
                '$dplink',
                radius: 90,
              )),
        ]),
      );
    else
      return SpinKitFadingCube(color: Colors.blue[300]);
  }
}
