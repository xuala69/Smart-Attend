import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_attend/providers/auth_provider.dart';
import 'package:smart_attend/providers/socket_provider.dart';

import 'home_screen.dart';
import 'login.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final socket = ref.watch(socketProvider);

      // Listen for messages from the server
      socket.on('attendanceResponse', (data) {
        print('Message from server: $data');
      });
      final isAuthenticated = ref.watch(authProvider);
      return isAuthenticated ? const HomeScreen() : const LoginScreen();
    });
  }
}
