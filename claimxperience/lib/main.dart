import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_storage/firebase_storage.dart';

//components
import './components/Login.dart';
import './components/MainPage.dart';
import './components/AccountInfo.dart';
import './components/CameraPage.dart';

List<CameraDescription> cameras;

Future<Null> main() async{
  cameras = await availableCameras();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      
  runApp(new MaterialApp(
      title: "ClaimXprerience",
      home: new Login(),
      routes: <String, WidgetBuilder>{
        "/MainPage": (BuildContext context) => new MainPage(cameras),
        "/Camera": (BuildContext context) => new CameraPage(cameras)
      }));
}

