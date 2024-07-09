// providers.dart
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

final faceDetectedProvider = StateProvider<bool>((ref) => false);
final countdownProvider = StateProvider<int>((ref) => 15);
final countdownControllerProvider = StateProvider<Timer?>((ref) => null);

void startFaceDetection(WidgetRef ref) {
  Timer(const Duration(seconds: 2), () {
    ref.read(faceDetectedProvider.notifier).state = true;
  });
}

void startTimer(WidgetRef ref) {
  // Cancel any existing timer
  ref.read(countdownControllerProvider.notifier).state?.cancel();

  // Reset the countdown to 15 seconds
  ref.read(countdownProvider.notifier).state = 15;

  // Start a new timer
  final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    final timeLeft = ref.read(countdownProvider);
    if (timeLeft > 0) {
      ref.read(countdownProvider.notifier).state--;
    } else {
      timer.cancel();
      ref.read(countdownControllerProvider.notifier).state = null;
    }
  });

  // Save the timer to cancel it if needed
  ref.read(countdownControllerProvider.notifier).state = timer;
}

final cameraControllerProvider = FutureProvider<CameraController>((ref) async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  final controller = CameraController(
    firstCamera,
    ResolutionPreset.high,
  );
  await controller.initialize();
  return controller;
});
