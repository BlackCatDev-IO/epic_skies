import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyToggleSwitch extends StatefulWidget {
  final bool settingsBool;
  final Function onToggle;

  const MyToggleSwitch({Key key, this.settingsBool, this.onToggle})
      : super(key: key);
  @override
  _MyToggleSwitchState createState() => _MyToggleSwitchState();
}

class _MyToggleSwitchState extends State<MyToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
// value: settingsController.notificationSound,
      value: widget.settingsBool,
      onChanged: (value) {
        setState(() {});
        // debugPrint(settingsController.notificationSound.toString());
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );
  }
}

class OBXToggleSwitch extends StatelessWidget {
  final bool settingsBool;

  const OBXToggleSwitch({@required this.settingsBool});

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (settingsBool) => Switch(
          value: settingsBool as bool,
          onChanged: (value) {
            settingsBool =
                value; // Rx has a _callable_ function! You could use (flag) => data.value = flag,
          }),
      false.obs,
    );
  }
}
