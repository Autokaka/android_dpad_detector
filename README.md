# android_dpad_detector

A widget to respond to Android DPad key event. Note that this widget is only for **Android TV** apps, it only helps solve some annoying problems when adapting your apps for Andoird TV platform.

## How to use it?

Simple enough. Just wrap a whatever widget you want with AndroidDPadDetector. For example, I want to make a TextButton respond to DPad `Select` event, I could write like this:

```dart
DPadDetector(
  onTap: () {
    /// On Android TV, this will respond when DPad "Select" button is pressed.
    /// On Android mobile phones, this will be the equal to `onTap` event.
  },
  onMenuTap: () {
    /// On Android TV, this will respond when DPad "MenuContext" button is pressed.
    /// On Android mobile phones, this will be equal to `onLongTap` event.
  },
  child: TextButton(...),
)
```

When there are complex focusable widgets in your page, for example: TextFormField, the normal FocusGroup will be behave abnormally. In that situation, you could use DPadFocusGroup. DPadFocusGroup helps you manage your FocusNodes in a List order you have just passed to this Widget. For example, if you want to manage the FocusNodes in your specified order in a group of child widgets including TextFormField, you could code like this:

```dart
List<FocusNode> focusNodeList = [
  FocusNode(),
  FocusNode(),
  FocusNode(),
];

/// ignored code...

DPadFocusGroup(
	focusNodeList: focusNodeList,
  children: [
    /// ①
    TextFormField(
    	focusNode: focusNodeList[0],
    ),
    /// ②
    DPadDetector(
      focusNode: focusNodeList[1],
      child: Text("text"),
    ),
    /// ③
    TextFormField(
    	focusNode: focusNodeList[2],
    ),
  ],
);
```

If you code like that, when you press →, ↓ on your DPad continually, your FocusNode will change like this: ①→②→③→①... 

When you press ←, ↑ on your DPad continually, your FocusNode will change like this: ①→③→②→①...
