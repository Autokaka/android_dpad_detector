import 'package:android_dpad_detector/dpad_detector.dart';
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
        leading: DPadDetector(
          onTap: Navigator.of(context).pop,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: Text("This is a second page"),
      ),
    );
  }
}
