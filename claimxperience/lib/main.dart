import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

//components
import './components/Login.dart';
import './components/MainPage.dart';
import './components/AccountInfo.dart';

void main(){
  runApp(new MaterialApp(
    title: "ClaimXprerience",
    home: _getLandingPage(),
    routes: <String, WidgetBuilder>{
      "/SecondPage": (BuildContext context) => new AccountInfo()
    }
    ));
}

Widget _getLandingPage() {
  return StreamBuilder<FirebaseUser>(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data.providerData.length == 1) { // logged in using email and password
          return MainPage();
        } else { // logged in using other providers
          return MainPage();
        }
      } else {
        return Login();
      }
    },
  );
}