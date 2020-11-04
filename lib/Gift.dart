import 'package:flutter/material.dart';
import 'package:newapp1/services/giftservice.dart';

import 'GiftClick.dart';

class GiftPop extends StatefulWidget {
  String docid;
  GiftPop({docid}) {
    this.docid = docid;
  }
  @override
  _GiftPopState createState() => _GiftPopState();
}

class _GiftPopState extends State<GiftPop> {
  int amount = 50;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 400,
        width: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Gift the Channel',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                )
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                    onPressed: () {
                      setState(() {
                        this.amount += 50;
                      });
                    },
                    child: Image.asset(
                      'assets/images/button.png',
                      width: 50,
                      height: 50,
                    )),

                Container(
                  height: 150,
                  width: 90,
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    '${this.amount}',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                ),
//                  Image.asset('assets/images/.png', width: 30, height: 30),
                FlatButton(
                    onPressed: () {
                      this.setState(() {
                        if (amount > 0) this.amount -= 50;
                      });
                    },
                    child: Image.asset(
                      'assets/images/button-.png',
                      width: 50,
                      height: 50,
                    )),
              ],
            ),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.white,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'RETURN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: FlatButton(
                      onPressed: () {
                        GiftService(
                                giftamount: this.amount, docid: widget.docid)
                            .sendGift();
                        print(widget.docid);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Gift(amount: this.amount)),
                        );
                      },
                      child: Text(
                        'Gift',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
