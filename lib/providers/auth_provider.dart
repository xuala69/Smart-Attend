import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, bool>((ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  void login(String email, String password) {
    // Implement your authentication logic here
    // For simplicity, we'll just set the state to true
    state = true;
  }

  void logout() {
    state = false;
  }
}
