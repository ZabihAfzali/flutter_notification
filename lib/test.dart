import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:rxdart/rxdart.dart';

class LocalNotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
  BehaviorSubject<ReceivedNotification>();

  LocalNotificationManager._privateConstructor();

  static final LocalNotificationManager instance =
  LocalNotificationManager._privateConstructor();

  Future<void> initialize() async {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings('logo'), // Replace 'app_icon' with the name of your app icon
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,);

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
  }

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'you_can_name_it_whatever4',
    'Meeting Notifications',
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('tu'), // Replace 'custom_sound' with your custom sound file name
  );

  Future<void> scheduleNotification(
      String meetingName, DateTime meetingTime) async {
    final DateTime now = DateTime.now();
    final int difference = meetingTime.difference(now).inSeconds;

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'you_can_name_it_whatever4',
      'Meeting Channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound('tu'),
      actions: [
        AndroidNotificationAction('as', 'cancel',titleColor: Colors.green),
        AndroidNotificationAction('ad', 'snooze',
        ),
      ]// Replace 'custom_sound' with your custom sound file name
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Meeting Reminder',
      'Meeting: $meetingName',
      tz.TZDateTime.from(meetingTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'Meeting: $meetingName',
    );
  }


}

class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });
}

class DateTimePickerScreen extends StatefulWidget {
  @override
  _DateTimePickerScreenState createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  final LocalNotificationManager notificationManager =
      LocalNotificationManager.instance;
  final TextEditingController meetingNameController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();

  Future<void> scheduleMeeting() async {
    final String meetingName = meetingNameController.text;
    await notificationManager.scheduleNotification(meetingName, selectedDateTime);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Meeting scheduled successfully')),
    );
  }

  Future<void> showDateTimePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (timePicked != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            timePicked.hour,
            timePicked.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DateTime Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          TextField(
          controller: meetingNameController,
          decoration: InputDecoration(labelText: 'Meeting Name'),
        ),
        SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Selected Date and Time:',
            style: TextStyle(fontSize: 16.0),
          ),
          subtitle: Text(
          '${selectedDateTime.toString()}',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: showDateTimePicker,
        child: Text('Pick Date and Time'),
      ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: scheduleMeeting,
        child: Text('Schedule Meeting'),
      ),
      ],
    ),
    ),
    );
  }
}

