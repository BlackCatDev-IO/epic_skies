// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class SettingsDrawer extends StatelessWidget {
//   final tabBarController = Get.find<TabBarController>();
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: DarkBlueGradientContainer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               child: Text(
//                 'Preferences',
//                 style: kGoogleFontOpenSansCondensed.copyWith(
//                     color: Colors.blue, fontSize: 50),
//               ).center(),
//               decoration: BoxDecoration(color: dialogBackgroundColor(context)),
//             ),
//             CustomListTile(
//                 title: 'Add Timer',
//                 onPressed: () {
//                   Get.back();
//                   tabBarController.jumpToStopwatchTab.value = false;
//                   TabBarController().tabBarControllerBox.write(
//                       'tab_index', TabBarController().jumpToStopwatchTab);

//                   if (GetPlatform.isIOS) {
//                     Get.to(AddTimerPageiOS());
//                   } else
//                     Get.to(AddTimerPageAndroid());
//                 },
//                 icon: Icons.add),
//             CustomListTile(
//               title: 'Add Stopwatch',
//               onPressed: () {
//                 Get.put(StopwatchController()).addStopwatchRow();
//                 Get.back();
//                 tabBarController.jumpToStopwatchTab.value = true;
//                 TabBarController().storeIndex(true);

//                 Get.to(HomePage());
//                 debugPrint('add stopwatch');
//               },
//               icon: Icons.add,
//             ),
//             CustomListTile(
//               icon: Icons.color_lens,
//               title: 'Themes',
//               onPressed: () {
//                 MyAlertDialogs().showThemeSelectionDialog(context);
//               },
//             ),
//             CustomListTile(
//                 title: 'Notifications',
//                 onPressed: () {
//                   MyAlertDialogs().showNotificationOptions();
//                 },
//                 icon: Icons.notifications_active),
//             ElevatedButton(
//               onPressed: () {
//                 final timerController = Get.find<TimerController>();
//                 timerController.timerListBox.erase();
//                 timerController.newTimerRowList.clear();
//                 Get.back();
//               },
//               child: Container(
//                   width: 80,
//                   height: 30,
//                   child: Center(child: Text('Erase Timer Box'))),
//             ).paddingOnly(bottom: 80),
//             ElevatedButton(
//               onPressed: () {
//                 final stopwatchController = Get.find<StopwatchController>();
//                 stopwatchController.stopwatchListBox.erase();
//                 stopwatchController.stopwatchRowList.clear();
//                 Get.back();
//               },
//               child: Container(
//                   width: 80,
//                   height: 30,
//                   child: Center(child: Text('Erase Stopwatch Box'))),
//             ).paddingOnly(bottom: 80)
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ThemeSettingsRow extends StatelessWidget {
//   final String title;

//   const ThemeSettingsRow({this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 50,
//             child: Card(
//               color: primaryColor(context),
//               child: Text(title),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class CustomListTile extends StatefulWidget {
//   final String title;
//   final Function onPressed;
//   final IconData icon;

//   const CustomListTile({this.title, this.onPressed, this.icon});

//   @override
//   _CustomListTileState createState() => _CustomListTileState();
// }

// final settingsController = Get.put(SettingsController());

// class _CustomListTileState extends State<CustomListTile> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: InkWell(
//         onTap: widget.onPressed,
//         splashColor: Colors.orangeAccent,
//         child: Container(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     widget.icon,
//                     color: Colors.lightBlueAccent,
//                     size: 25,
//                   ),
//                   const SizedBox(width: 7.5),
//                   Text(
//                     widget.title,
//                     style: TextStyle(fontSize: 17, color: Colors.blue),
//                   ).paddingAllSides(8),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NotificationSettingsRow extends StatelessWidget {
//   final String title;
//   final bool setting;

//   const NotificationSettingsRow({Key key, this.title, this.setting})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final settingsController = Get.put(SettingsController());
//     return Expanded(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style:
//                 kOpenSansCondensed.copyWith(color: Colors.blue, fontSize: 20),
//           ),
//           ObxValue(
//             (settingsBool) => Switch(
//                 value: settingsController.notificationSound.value,
//                 onChanged: (value) {
//                   settingsController.notificationSound.value = value; // Rx
//                 }),
//             false.obs,
//           )
//         ],
//       ).paddingOnlySymmetric(horizontal: 16),
//     );
//   }
// }
