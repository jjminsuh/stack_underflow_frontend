import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen ({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  var _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid); //, initializationSettingsIOS);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
        // ,onSelectNotification: onSelectNotification);
  }

  /*Future<void> onSelectNotification(String payload) async {
    debugPrint("$payload");
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Notification Payload'),
          content: Text('Payload: $payload'),
        ));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            TextButton(
              onPressed: (
                  ) {
                _repeatNotification();
              },
              child: const Text('Notification'),
            )],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _repeatNotification() async {
    var android = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);

    // var ios = IOSNotificationDetails();
    var detail = NotificationDetails(android: android); //, ios);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '반복 Notification',
      '반복 Notification 내용',
      RepeatInterval.hourly,
      detail
      // payload: 'Hello Flutter',
    );
  }

}



