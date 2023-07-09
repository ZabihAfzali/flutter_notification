import 'package:flutter/material.dart';
import 'package:flutter_local_notification_practice/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Noti.initializeNotifications(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Notificaions'),
      ),
      body: Center(
        child: Container(
          width: 100,
            height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: (){
              Noti.showBigTextNotificaion(title: 'Message title', body: 'Your long  body', fln: flutterLocalNotificationsPlugin);
            },child: Text('Click here'),
          ),
        ),
      ),
    );
  }
}
