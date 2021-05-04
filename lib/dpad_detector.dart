library dpad_detector;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/dpad_focus_group.dart';

class DPadDetector extends StatefulWidget {
  final Widget child;
  final FocusNode? focusNode;
  final Color focusColor;
  final void Function()? onTap;

  DPadDetector({
    Key? key,
    required this.child,
    this.focusNode,
    this.focusColor = Colors.blue,
    this.onTap,
  }) : super(key: key);

  @override
  _DPadDetectorState createState() => _DPadDetectorState();
}

class _DPadDetectorState extends State<DPadDetector> {
  late FocusNode focusNode;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(didChangeFocusNode);
  }

  void didChangeFocusNode() {
    if (hasFocus != focusNode.hasFocus) {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: FocusNode(
        onKey: (node, event) {
          if (event.runtimeType != RawKeyUpEvent) {
            return;
          }
          if (event.data.logicalKey.keyId == LogicalKeyboardKey.select.keyId) {
            widget.onTap?.call();
          }
        },
      ),
      child: Focus(
        focusNode: focusNode,
        child: Container(
          margin: hasFocus ? EdgeInsets.all(5) : null,
          decoration: BoxDecoration(
            color: hasFocus ? widget.focusColor.withOpacity(0.2) : null,
            border: hasFocus ? Border.all(color: widget.focusColor) : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.removeListener(didChangeFocusNode);
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
