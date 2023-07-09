// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class LocalNotification extends StatefulWidget {
//   @override
//   _LocalNotificationState createState() => _LocalNotificationState();
// }
//
// class _LocalNotificationState extends State<LocalNotification> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> _showNotification() async {
//     var androidDetails = AndroidNotificationDetails(
//         'channelId', 'channelName', 'channelDescription',
//         importance: Importance.high,
//         priority: Priority.high,
//         ticker: 'test');
//
//     var iOSDetails = IOSNotificationDetails();
//
//     var generalNotificationDetails =
//     NotificationDetails(android: androidDetails, iOS: iOSDetails);
//
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'title',
//         'body',
//         generalNotificationDetails,
//         payload: 'test payload',
//         actions: [
//           NotificationActionButton(
//               key: 'yes',
//               label: 'Yes',
//               buttonType: ActionButtonType.Default),
//           NotificationActionButton(
//               key: 'no',
//               label: 'No',
//               buttonType: ActionButtonType.Default),
//         ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Local Notification'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _showNotification();
//           },
//           child: Text('Show Notification'),
//         ),
//       ),
//     );
//   }
// }
