import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'main.dart';

class Noti{
  static  Future initializeNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final initializationSettingsAndroid =
    AndroidInitializationSettings('logo');
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotificaion({var id=0, required String title, required String body, var payload,
  required FlutterLocalNotificationsPlugin fln}) async{
    AndroidNotificationDetails androidPlateformChanelSpecific=new AndroidNotificationDetails(
        'you_can_name_it_whatever3', 'alarm',
        playSound: true,
      sound: RawResourceAndroidNotificationSound('tu'),
      importance: Importance.max,
      priority: Priority.high,
      actions: [

      ]
    );

    var not=NotificationDetails(android: androidPlateformChanelSpecific);
    await fln.show(0, title, body, not);
  }
}

