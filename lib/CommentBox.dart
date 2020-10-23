import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment down'),
      ),
      body: TextField(
        decoration: InputDecoration(
          labelText: 'write the comment here',
          border: InputBorder.none,
          hintText: 'enter the comment here',
        ),
      ),
    );
  }
}
