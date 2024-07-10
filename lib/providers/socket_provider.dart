import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_attend/main.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketProvider = Provider<IO.Socket>((ref) {
  final socket = IO.io('http://192.168.1.38:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  // Connect to the Socket.IO server
  socket.connect();

  // Listen for messages from the server
  socket.on('attendanceResponse', (data) {
    log('Message from server: $data');
    _showNotification(data);
    // You can display the response in your app's UI
  });

  return socket;
});

void _showNotification(String message) async {
  log("Show local notification:$message");
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    '1',
    'Notifications',
    channelDescription: 'General Notification',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(
        0,
        'Server Response',
        message,
        platformChannelSpecifics,
        payload: 'item x',
      )
      .onError((error, stackTrace) => log("onError:$stackTrace"))
      .catchError((err) {
    log("catchError:$err");
  });
}
