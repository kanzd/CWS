import 'package:flutter/material.dart';
import 'package:newapp1/services/auth.dart';
import 'package:toast/toast.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy and Security'),
        centerTitle: true,
      ),
      body: Center(
          child: FlatButton(
        onPressed: () async {
          Auth().sendcode();

          // await showDialog(
          //     context: context,
          //     builder: (context) {
          //       return AlertDialog(
          //           actions: [
          //             FlatButton(
          //                 onPressed: () {
          //                   Auth().comfirm(
          //                       code: controller.text,
          //                       newpasscode: controller2.text);
          //                   Navigator.pop(context);
          //                   Toast.show('Password Changed', context);
          //                 },
          //                 child: Text('Change Your Password'))
          //           ],
          //           title: Text('Change Password'),
          //           content: Container(
          //             height: 130,
          //             child: Column(
          //               children: [
          //                 TextField(
          //                   controller: controller,
          //                   decoration: InputDecoration(
          //                       hintText: 'Enter Verification code'),
          //                 ),
          //                 TextField(
          //                   controller: controller2,
          //                   decoration:
          //                       InputDecoration(hintText: 'New Passcode'),
          //                 )
          //               ],
          //             ),
          //           ));
          //     });
          Toast.show(
              "Password Reset Link sent to your registered email", context,duration: 3);
        },
        color: Colors.blue,
        child: Text("Change Your Password"),
      )),
    );
  }
}
