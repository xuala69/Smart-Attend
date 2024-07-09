import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TestSocketPage extends StatefulWidget {
  const TestSocketPage({super.key});

  @override
  State<TestSocketPage> createState() => _TestSocketPageState();
}

class _TestSocketPageState extends State<TestSocketPage> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    // Initialize the Socket.IO client
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to the Socket.IO server
    socket.connect();

    // Listen for messages from the server
    socket.on('attendanceResponse', (data) {
      log('Message from server: $data');
      // You can display the response in your app's UI
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Response from Server'),
            content: Text(data),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Send a message to the server
            Fluttertoast.showToast(
              msg: 'Sending attendance...',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            socket.emit('attendance', 'New Attendance');
          },
          child: const Text('Send Attendance'),
        ),
      ),
    );
  }
}
