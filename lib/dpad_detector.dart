library dpad_detector;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_animations/simple_animations.dart';

part 'src/dpad_focus_group.dart';

class DPadDetector extends StatefulWidget {
  final Widget child;
  final FocusNode? focusNode;
  final Color focusColor;
  final double focusRadius;
  final void Function()? onTap;
  final void Function()? onMenuTap;
  final void Function()? onVolumeUpTap;
  final void Function()? onVolumeDownTap;

  DPadDetector({
    Key? key,
    required this.child,
    this.focusNode,
    this.focusColor = Colors.blue,
    this.focusRadius = 5.0,
    this.onTap,
    this.onMenuTap,
    this.onVolumeUpTap,
    this.onVolumeDownTap,
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
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (event) {
        if (event.runtimeType != RawKeyUpEvent) {
          return;
        }
        if (event.logicalKey == LogicalKeyboardKey.select) {
          widget.onTap?.call();
        }
        if (event.logicalKey == LogicalKeyboardKey.contextMenu) {
          widget.onMenuTap?.call();
        }
        if (event.logicalKey == LogicalKeyboardKey.audioVolumeUp) {
          widget.onVolumeUpTap?.call();
        }
        if (event.logicalKey == LogicalKeyboardKey.audioVolumeDown) {
          widget.onVolumeDownTap?.call();
        }
      },
      child: GestureDetector(
        onTapDown: (_) {
          focusNode.requestFocus();
        },
        onTapUp: (_) {
          focusNode.unfocus();
          widget.onTap?.call();
        },
        onTapCancel: () {
          focusNode.unfocus();
        },
        onLongPress: () {
          widget.onMenuTap?.call();
        },
        child: CustomAnimation<double>(
          control: hasFocus
              ? CustomAnimationControl.play
              : CustomAnimationControl.playReverse,
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 250),
          builder: (context, child, value) {
            return Container(
              margin: EdgeInsets.all(value * 5),
              decoration: BoxDecoration(
                color: widget.focusColor.withOpacity(value * 0.2),
                border: Border.all(
                  color: widget.focusColor.withOpacity(value),
                  width: value,
                ),
                borderRadius: BorderRadius.circular(widget.focusRadius),
              ),
              child: widget.child,
            );
          },
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
