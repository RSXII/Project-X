import 'package:flutter/material.dart';

class VerifyEmailPage extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Video Collaboration',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blue.shade400,
      body: new Container(
          alignment: Alignment.topCenter,
          child: new Column(
            children: <Widget>[],
          )),
    );
  }
}