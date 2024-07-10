import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_attend/providers/auth_provider.dart';
import 'package:smart_attend/providers/socket_provider.dart';

import 'home_screen.dart';
import 'login.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});

  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends ConsumerState<RootPage> {
  @override
  void initState() {
    super.initState();
    // Access the socket provider and connect
    final socket = ref.read(socketProvider);
    socket.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final isAuthenticated = ref.watch(authProvider);
      return isAuthenticated ? const HomeScreen() : const LoginScreen();
    });
  }
}

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => RootPageState();
// }

// class RootPageState extends State<RootPage> {
//   late IO.Socket socket;

//   @override
//   void initState() {
//     super.initState();
//     final socket = ref.read(socketProvider);

//     // Initialize the Socket.IO client
//     socket = IO.io('http://192.168.29.213:3000', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     // Connect to the Socket.IO server
//     socket.connect().onConnectError((data) => log("onConnectError: $data"));

//     // Listen for messages from the server
//     socket.on('attendanceResponse', (data) {
//       log('Message from server: $data');
//       // You can display the response in your app's UI
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Response from Server'),
//             content: Text(data),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     });
//   }

//   @override
//   void dispose() {
//     socket.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, child) {
//       final isAuthenticated = ref.watch(authProvider);
//       return isAuthenticated ? const HomeScreen() : const LoginScreen();
//     });
//   }
// }
