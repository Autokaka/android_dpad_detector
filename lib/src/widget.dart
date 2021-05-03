part of android_dpad_detector;

class AndroidDPadDetector extends StatefulWidget {
  final Widget child;
  final FocusNode? focusNode;
  final Color focusColor;
  final void Function()? onKeyLeft;
  final void Function()? onKeyUp;
  final void Function()? onKeyRight;
  final void Function()? onKeyDown;
  final void Function()? onKeyCenter;

  AndroidDPadDetector({
    Key? key,
    required this.child,
    this.focusNode,
    this.focusColor = Colors.blue,
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
  late FocusNode focusNode;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(didGainFocusListener);
  }

  void didGainFocusListener() {
    if (hasFocus != focusNode.hasFocus) {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(
      Platform.isAndroid,
      "Please note that this package "
      "is only for Android TV apps.",
    );
    return GestureDetector(
      onTap: () => widget.onKeyCenter?.call(),
      child: RawKeyboardListener(
        child: Container(
          decoration: BoxDecoration(
            border: hasFocus
                ? Border.all(
                    color: widget.focusColor,
                  )
                : null,
          ),
          child: widget.child,
        ),
        focusNode: focusNode,
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
      ),
    );
  }

  @override
  void dispose() {
    focusNode.removeListener(didGainFocusListener);
    focusNode.dispose();
    widget.focusNode?.dispose();
    super.dispose();
  }
}
