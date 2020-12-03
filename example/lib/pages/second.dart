import 'package:android_dpad_detector/android_dpad_detector.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AndroidDPadDetector(
          child: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          onKeyCenter: Navigator.of(context).pop,
        ),
        title: Text("This is a second page"),
      ),
    );
  }
}
