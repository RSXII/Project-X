import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainPage extends StatelessWidget {
  var cameras;
  MainPage(this.cameras);
  void _signOut() {
    FirebaseAuth.instance.signOut();
  }

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
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.camera_alt, size: 28.0,),
            padding: EdgeInsets.only(right: 30.0),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/Camera');
            },
          )
        ],
      ),
      backgroundColor: Colors.blue.shade400,
      body: new Container(
          alignment: Alignment.topCenter,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(20.0),
              ),
              new FutureBuilder<FirebaseUser>(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (BuildContext context,
                      AsyncSnapshot<FirebaseUser> snapshot) {
                    return snapshot.data.photoUrl != null
                        ? Container(
                            width: 200.0,
                            height: 200.0,
                            child: new Image.network(
                              snapshot.data.photoUrl,
                            ))
                        : Container(
                            width: 200.0,
                            height: 200.0,
                            child: new Icon(Icons.account_circle,
                                color: Colors.white, size: 200.0));
                  }),
              new Padding(padding: EdgeInsets.all(20.0)),
              new FutureBuilder<FirebaseUser>(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (BuildContext context,
                      AsyncSnapshot<FirebaseUser> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data.displayName != null
                          ? new Text('User: ${snapshot.data.displayName}',
                              style: TextStyle(
                                  fontSize: 24.0, color: Colors.white))
                          : new Container();
                    } else {
                      return new Text('Loading......');
                    }
                  }),
              new FutureBuilder<FirebaseUser>(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (BuildContext context,
                      AsyncSnapshot<FirebaseUser> snapshot) {
                    return new Text('Email: ${snapshot.data.email}',
                        style: TextStyle(fontSize: 24.0, color: Colors.white));
                  }),
              new Expanded(
                  child: new Align(
                      alignment: Alignment.bottomCenter,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new MaterialButton(
                            onPressed: () {
                              _signOut;
                              Navigator.pop(context);
                            },
                            child: new Text('Sign Out',
                                style: TextStyle(color: Colors.white)),
                            color: Colors.blue.shade800,
                            splashColor: Colors.grey,
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(bottom: 16.0),
                          )
                        ],
                      )))
            ],
          )),
    );
  }
}
