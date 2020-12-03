part of android_dpad_detector;

class AndroidDPadKeyEvent {
  const AndroidDPadKeyEvent._();

  /// Since there seems to have some errors like
  ///
  /// > Attempted to send a key down event when no
  /// > keys are in keysPressed. This state can occur
  /// > if the key event being sent doesn't properly
  /// > set its modifier flags. This was the event...
  ///
  /// when KEY_CENTER is triggered, we need
  /// to get the string source of the event
  /// to judget DPad key event instead.
  static bool match(RawKeyEvent event) {
    String eventDataStr = event.data.toString();
    return eventDataStr.contains("RawKeyEventDataAndroid");
  }

  /// Since there seems to have some errors like
  ///
  /// > Attempted to send a key down event when no
  /// > keys are in keysPressed. This state can occur
  /// > if the key event being sent doesn't properly
  /// > set its modifier flags. This was the event...
  ///
  /// when KEY_CENTER is triggered, we need
  /// to get the string source of the event
  /// to retrieve DPad key code instead.
  static int retrieveKeyCode(RawKeyEvent event) {
    String eventDataStr = event.data.toString();
    RegExp keyCodeExp = RegExp(r"keyCode: (\d*),");
    String keyCodeStr = keyCodeExp.firstMatch(eventDataStr).group(1);
    return int.parse(keyCodeStr);
  }

  static const int KEY_UP = 19;
  static const int KEY_DOWN = 20;
  static const int KEY_LEFT = 21;
  static const int KEY_RIGHT = 22;
  static const int KEY_CENTER = 23;
}
