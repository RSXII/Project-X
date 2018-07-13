import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class CameraPage extends StatefulWidget {
  List<CameraDescription> cameras;

  CameraPage(this.cameras);

  @override
  State<StatefulWidget> createState() {
    return new CameraPageState();
  }
}

class CameraPageState extends State<CameraPage> {
  CameraController controller;
  double cameraSize;

  Future<Null> uploadFile(String filepath) async{
    final ByteData bytes = await rootBundle.load(filepath);
    final Directory tempDir = Directory.systemTemp;
    final String fileName = "Img_${Random().nextInt(10000)}.jpg";
    final File file = File('${tempDir.path}/$fileName');
    file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

    final StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask task = ref.putFile(file);
    

  }

  @override
  void initState() {
    super.initState();
    controller =
        new CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraSize = controller.value.aspectRatio / 0.95;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return new Container(
        child: new Column(
      children: <Widget>[
        new AppBar(
          title: new Text(
            'Live Video',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        new Container(
            height: 500.0,
            width: MediaQuery.of(context).size.width,
            child: new CameraPreview(controller)),
        new Container(
            padding: EdgeInsets.only(top: 10.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new FlatButton(
                  padding: EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.camera,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print(controller.value.aspectRatio);
                  },
                ),
                new FlatButton(
                  padding: EdgeInsets.all(18.0),
                  child: new Transform.rotate(
                    angle: 1.55,
                    child: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print(controller.value.aspectRatio);
                  },
                ),
                new FlatButton(
                  padding: EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    print(controller.value.aspectRatio);
                  },
                ),
              ],
            ))
      ],
    ));
  }
}
