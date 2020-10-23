import 'package:flutter/material.dart';

class FifthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.history, size: 20.0),
                SizedBox(width: 15.0),
                Text("History",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.download_sharp, size: 20.0),
                SizedBox(width: 15.0),
                Text("Downloads",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.video_collection_sharp, size: 20.0),
                SizedBox(width: 15.0),
                Text("Your Videos",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.label_outline_sharp, size: 20.0),
                SizedBox(width: 15.0),
                Text("Purchases",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.watch_later, size: 20.0),
                SizedBox(width: 15.0),
                Text("Watch Later",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            margin: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Divider(
              color: Colors.white10,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child: Row(
              children: [
                Text("Playlists"),
                Spacer(),
                Text("Recently added"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.add, size: 20.0, color: Colors.blue),
                SizedBox(width: 15.0),
                Text("New Playlist",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.thumbs_up_down, size: 20.0),
                SizedBox(width: 15.0),
                Text("Liked Videos",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
