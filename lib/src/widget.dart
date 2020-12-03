part of android_dpad_detector;

class AndroidDPadDetector extends StatefulWidget {
  final Widget child;
  final FocusNode focusNode;
  final void Function() onKeyLeft;
  final void Function() onKeyUp;
  final void Function() onKeyRight;
  final void Function() onKeyDown;
  final void Function() onKeyCenter;

  AndroidDPadDetector({
    Key key,
    @required this.child,
    this.focusNode,
    this.onKeyLeft,
    this.onKeyUp,
    this.onKeyRight,
    this.onKeyDown,
    this.onKeyCenter,
  }) : super(key: key);

  @override
  _AndroidDPadDetectorState createState() => _AndroidDPadDetectorState();
}

class _AndroidDPadDetectorState extends State<AndroidDPadDetector> {
  @override
  Widget build(BuildContext context) {
    assert(
      Platform.isAndroid,
      "Please note that this package "
      "is only for Android TV apps.",
    );
    return RawKeyboardListener(
      child: widget.child,
      focusNode: widget.focusNode ?? FocusNode(),
      onKey: (RawKeyEvent event) {
        if (!AndroidDPadKeyEvent.match(event)) return;
        switch (AndroidDPadKeyEvent.retrieveKeyCode(event)) {
          case AndroidDPadKeyEvent.KEY_LEFT:
            widget.onKeyLeft?.call();
            break;
          case AndroidDPadKeyEvent.KEY_UP:
            widget.onKeyUp?.call();
            break;
          case AndroidDPadKeyEvent.KEY_RIGHT:
            widget.onKeyRight?.call();
            break;
          case AndroidDPadKeyEvent.KEY_DOWN:
            widget.onKeyDown?.call();
            break;
          case AndroidDPadKeyEvent.KEY_CENTER:
            widget.onKeyCenter?.call();
            break;
        }
      },
    );
  }
}
