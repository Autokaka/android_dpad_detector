import 'package:example/pages/second.dart';
import 'package:flutter/material.dart';
import 'package:android_dpad_detector/dpad_detector.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Center(
        child: DPadDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SecondPage(),
              ),
            );
          },
          child: TextButton(
            onPressed: () {},
            child: Text("Launch SecondPage"),
          ),
        ),
      ),
    );
  }
}
