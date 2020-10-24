import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp1/services/videos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import './services/fileselect.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:hashtagable/hashtagable.dart';

class Upload_Screen extends StatefulWidget {
  @override
  _Upload_ScreenState createState() => _Upload_ScreenState();
}

class _Upload_ScreenState extends State<Upload_Screen> {
  File image, video;
  bool load = false;
  String type;
  Color color;

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        isLoading: load,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'Upload Video',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: 'ENTER THE TITLE'),
                  ),
                  TextField(
                    keyboardType: TextInputType.datetime,
                    controller: controller2,
                    decoration:
                        InputDecoration(hintText: 'Length {hrs:min:sec}'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton(
                    hint: Text(type == null ? 'Select type' : type,
                        style: TextStyle(color: color==null?Colors.grey:color)),
                    onChanged: (e) {
                      print(e);
                      this.type = e[0];
                      this.color = e[1];
                      setState(() {
                        print(this.type);
                      });
                    },
                    items: [
                      ['Music', Colors.green],
                      ['Sports', Colors.red],
                      ['Games', Colors.brown],
                      ['Movies', Colors.blue]
                    ]
                        .map((e) => DropdownMenuItem(
                              child: Text(
                                e[0],
                                style: TextStyle(color: e[1]),
                              ),
                              value: e,
                              onTap: () {},
                            ))
                        .toList(),
                  ),
                  HashTagTextField(
                    decoration: InputDecoration(
                        hintText: 'Enter the hashtag for you video(optional)'),
                    controller: controller3,
                    decorateAtSign: true,
                    decoratedStyle: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      image != null
                          ? Image.file(
                              image,
                              height: 80,
                              frameBuilder: (context, child, frame, syn) {
                                return Container(
                                  child: child,
                                  color: Colors.black,
                                  padding: EdgeInsets.all(10),
                                );
                              },
                            )
                          : Text('Set The Thumbnail'),
                      SizedBox(
                        width: 60,
                      ),
                      FlatButton(
                        onPressed: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: ListView(
                                    children: [
                                      SizedBox(
                                        height: 90,
                                      ),
                                      ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text('camera'),
                                          onTap: () async {
                                            var image = await Image_Service(
                                                    selecttype: 'camera')
                                                .image();
                                            this.image = image;
                                            setState(() {});
                                            Navigator.pop(context);
                                          }),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ListTile(
                                          leading: Icon(Icons.storage),
                                          title: Text('Gallery'),
                                          onTap: () async {
                                            var image = await Image_Service(
                                                    selecttype: 'gallery')
                                                .image();
                                            this.image = image;
                                            setState(() {});
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  ),
                                  title: Text('Select'),
                                );
                              });
                        },
                        child: Text('Upload'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      flag ? Icon(Icons.done) : Icon(Icons.pending),
                      SizedBox(
                        width: 40,
                      ),
                      FlatButton(
                        onPressed: () async {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: ListView(
                                    children: [
                                      SizedBox(
                                        height: 90,
                                      ),
                                      ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text('camera'),
                                          onTap: () async {
                                            setState(() {
                                              load = true;
                                            });

                                            var image = await Image_Service(
                                                    selecttype: 'camera')
                                                .video();
                                            video = image;
                                            setState(() {
                                              load = false;
                                              flag = true;
                                            });
                                            Navigator.pop(context);
                                          }),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ListTile(
                                          leading: Icon(Icons.storage),
                                          title: Text('Gallery'),
                                          onTap: () async {
                                            setState(() {
                                              load = true;
                                            });

                                            var image = await Image_Service(
                                                    selecttype: 'gallery')
                                                .video();
                                            video = image;
                                            setState(() {
                                              load = false;
                                              flag = true;
                                            });
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  ),
                                  title: Text('Select'),
                                );
                              });
                        },
                        child: Text("Upload Video"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    onPressed: () async {
                      if ((image != null) && (video != null)) {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        setState(() {
                          load = true;
                        });
                        
                        Toast.show('Uploading....', context, duration: 5);
                        await Videos(docid: pref.getStringList('your info')[3])
                            .uploadVideo(
                                file: video,
                                thumbnail: image,
                                
                                docid: pref.getStringList('your info')[3],
                                time: DateTime.now(),
                                type: type,
                                hashtag: controller3.text,
                                length: controller2.text,
                                title: controller.text);
                        setState(() {
                          load = false;
                        });
                        Toast.show('Uploading done', context, duration: 4);
                        Navigator.pop(context);
                      } else {
                        Alert(
                                type: AlertType.error,
                                context: context,
                                title: "No Video or No thumbnail is given",
                                desc: "Plz Provide The media to upload")
                            .show();
                      }
                    },
                    child: Text('Next',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                        )),
                  ),
                ],
              )),
        ));
  }
}
