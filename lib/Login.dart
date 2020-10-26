import 'package:flutter/material.dart';
import 'package:newapp1/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Tabs.dart';
import 'signup.dart';
import 'CustomBorder.dart';
import 'CustomColors.dart';
import 'CustomTextStyle.dart';
import 'CustomUtils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool auth = true;

  fun() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('auth')) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyTabs()));
    }
  }

  @override
  Widget build(BuildContext context) {
    fun();
    return Scaffold(
      key: key,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Builder(builder: (context) {
        return Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image(
                    image: AssetImage("images/logo.png"),
                    height: 400,
                    alignment: Alignment.center,
                    width: 500),
                flex: 40,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: controller1,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                            border: CustomBorder.enabledBorder,
                            labelText: "Email",
                            hasFloatingPlaceholder: true,
                            focusedBorder: CustomBorder.focusBorder,
                            errorBorder: CustomBorder.errorBorder,
                            enabledBorder: CustomBorder.enabledBorder,
                            labelStyle: CustomTextStyle.textFormFieldMedium
                                .copyWith(
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            16,
                                    color: Colors.black)),
                      ),
                      Utils.getSizedBox(height: 20),
                      TextFormField(
                        controller: controller2,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                            border: CustomBorder.enabledBorder,
                            labelText: "Password",
                            hasFloatingPlaceholder: true,
                            focusedBorder: CustomBorder.focusBorder,
                            errorBorder: CustomBorder.errorBorder,
                            enabledBorder: CustomBorder.enabledBorder,
                            labelStyle: CustomTextStyle.textFormFieldMedium
                                .copyWith(
                                    fontSize:
                                        MediaQuery.of(context).textScaleFactor *
                                            16,
                                    color: Colors.black)),
                        obscureText: true,
                      ),
                      Utils.getSizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () async {
                            var auth = await Auth(
                                    email: controller1.text,
                                    passcode: controller2.text)
                                .login();

                            if (auth[0]) {
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => MyTabs()));
                            } else {
                              key.currentState.showSnackBar(SnackBar(
                                content: Text(auth[1].code),
                              ));
                            }
                          },
                          child: Text(
                            "LOGIN",
                            style: CustomTextStyle.textFormFieldRegular
                                .copyWith(color: Colors.white, fontSize: 14),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                        ),
                      ),
                      Utils.getSizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Text(
                            "Forget Password?",
                            style: CustomTextStyle.textFormFieldBold
                                .copyWith(color: Colors.blue, fontSize: 14),
                          ),
                        ),
                      ),
                      Utils.getSizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Colors.grey.shade200,
                              margin: EdgeInsets.only(right: 16),
                              height: 1,
                            ),
                            flex: 40,
                          ),
                          Text(
                            "Or",
                            style: CustomTextStyle.textFormFieldMedium
                                .copyWith(fontSize: 14),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.grey.shade200,
                              margin: EdgeInsets.only(left: 16),
                              height: 1,
                            ),
                            flex: 40,
                          )
                        ],
                      ),
                      Utils.getSizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            "FACEBOOK LOGIN",
                            style: CustomTextStyle.textFormFieldMedium
                                .copyWith(color: Colors.white, fontSize: 14),
                          ),
                          color: CustomColors.COLOR_FB,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                        ),
                      ),
                      Utils.getSizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account?",
                            style: CustomTextStyle.textFormFieldMedium
                                .copyWith(fontSize: 14),
                          ),
                          Utils.getSizedBox(width: 4),
                          GestureDetector(
                            child: Text(
                              "Sign Up",
                              style: CustomTextStyle.textFormFieldBold
                                  .copyWith(fontSize: 14, color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => SignUp()));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                flex: 60,
              )
            ],
          ),
        );
      }),
    );
  }
}
