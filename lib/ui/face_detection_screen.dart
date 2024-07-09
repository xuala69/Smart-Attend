import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_attend/ui/code_page.dart';
import 'package:smart_attend/utils/colors.dart';
import 'dart:async';

import 'package:smart_attend/utils/widgets.dart';

class MarkAttendancePage extends StatefulWidget {
  const MarkAttendancePage({super.key});

  @override
  MarkAttendancePageState createState() => MarkAttendancePageState();
}

class MarkAttendancePageState extends State<MarkAttendancePage> {
  CameraController? _controller;
  int _timerSeconds = 15;
  Timer? _timer;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _startTimer();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.last;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await _controller!.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        _timer?.cancel();
        _showTimeUpDialog();
      }
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Time\'s up!'),
        content: const Text('Would you like to retry?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _timerSeconds = 15;
              });
              _startTimer();
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(left: 15, top: 15),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
          ),
        ),
        actions: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/prof.png"),
              ),
            ),
          ),
          hs(15),
        ],
      ),
      body: _isCameraInitialized
          ? Column(
              children: [
                vs(25),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: CameraPreview(_controller!),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              )),
                          child: Center(
                            child: Container(
                              height: 10,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Timer $_timerSeconds seconds left',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Keep your app in foreground',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    hs(25),
                    Expanded(
                      child: Hero(
                        tag: "MarkAttendanceBtn",
                        child: MaterialButton(
                          onPressed: () {
                            _controller?.dispose();
                            _timer?.cancel();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CodeEntryScreen(),
                              ),
                            );
                          },
                          color: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          )),
                          child: Text(
                            'Capture',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    hs(25),
                  ],
                ),
                vs(80),
                Text(
                  "Powered by Lucify",
                  style: GoogleFonts.roboto(),
                ),
                vs(25)
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
