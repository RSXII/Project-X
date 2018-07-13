import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class _LoginData {
  String email = '';
  String password = '';
}

class LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  _LoginData _data = new _LoginData();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);
    Navigator.pushNamed(context, '/MainPage');
    return user;
  }

  _signInEmail(BuildContext context) async {
    _formKey.currentState.save();
    if(_data.email == '' || _data.password == ''){
      print('Missing email or password');
      return null;
    }
    FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _data.email, password: _data.password);
    // print(user);
    Navigator.pushNamed(context, '/MainPage');
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print('User Signed Out');
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
      ),
      backgroundColor: Colors.blue.shade400,
      body: new Container(
          alignment: Alignment.topCenter,
          child: new Column(
            children: <Widget>[
              new Padding(
                  padding: new EdgeInsets.all(6.0),
                  child: new Image.asset(
                    'images/banner_image.png',
                    width: 190.0,
                    height: 190.0,
                  )),
              new Container(
                  height: 260.0,
                  width: 380.0,
                  // color: Colors.white70,
                  child: new Column(
                    children: <Widget>[
                      new Theme(
                        data: new ThemeData(hintColor: Colors.white),
                        child: Container(
                            width: 240.0,
                            child: new Form(
                              key: this._formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter an email';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      labelText: 'Enter an email',
                                    ),
                                    onSaved: (String value) {
                                      this._data.email = value;
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      labelText: 'Enter a password',
                                    ),
                                    onSaved: (String value) {
                                      this._data.password = value;
                                    },
                                  ),
                                ],
                              ),
                            )),
                      ),
                      new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                      Container(
                          height: 50.0,
                          width: 240.0,
                          child: new Column(
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new RaisedButton(
                                    onPressed: () async {
                                      _signInEmail(context);
                                    },
                                    child: new Text('Sign In',
                                        style: TextStyle(color: Colors.white)),
                                    color: Colors.blue,
                                    splashColor: Colors.grey,
                                  ),
                                  new RaisedButton(
                                    onPressed: _signOut,
                                    child: new Text('Register',
                                        style: TextStyle(color: Colors.white)),
                                    color: Colors.blue,
                                    splashColor: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          )),
                      new Padding(padding: new EdgeInsets.all(10.0)),
                      new Container(
                          height: 50.0,
                          width: 240.0,
                          child: new Row(
                            children: <Widget>[
                              new MaterialButton(
                                height: 50.0,
                                minWidth: 240.0,
                                child: new Row(
                                  children: <Widget>[
                                    new Image.asset('images/google_logo.png',
                                        width: 50.0, height: 50.0),
                                    new Padding(
                                      padding: EdgeInsets.only(right: 14.0),
                                    ),
                                    new Text('Sign In with Google',
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                                color: Colors.grey.shade200,
                                padding: EdgeInsets.only(
                                    top: 6.0, bottom: 6.0, right: 14.0),
                                elevation: 0.0,
                                splashColor: Colors.grey,
                                onPressed: () =>
                                    _signIn(context).then((FirebaseUser user) {
                                      if (user == null) {
                                        print('result was null');
                                      }
                                      print(user);
                                    }).catchError((e) => print(e)),
                              ),
                            ],
                          )),
                    ],
                  )),
              new Expanded(
                  child: new Align(
                alignment: Alignment.bottomCenter,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                      'Powered by ClaimXperience™',
                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    new Text(
                      'a product of Xactware®',
                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: 8.0),
                      child: new Text(
                        'version 3.2.3',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(bottom: 16.0),
                    )
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
