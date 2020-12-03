# android_dpad_detector

A widget to respond to Android DPad key event. Node that this widget is only for Android TV apps.

## How to use it?

Simple enough. Just wrap a whatever widget you want with AndroidDPadDetector. For example, I want to make a TextButton respond to DPad KEY_CENTER event, I could write like this:

```dart
AndroidDPadDetector(
  onKeyCenter: () {
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
)
```

## What is it for?

It uses RegExp way to simply bypass RawKeyEvent codes in flutter service.dart, in order to make dpad key event available on Android TV apps.

