import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_attend/ui/root_page.dart';
import 'package:smart_attend/utils/colors.dart';
import 'package:smart_attend/utils/fade_route.dart';
import 'package:smart_attend/utils/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _startAnimation = false;
  bool _changeBackgroundColor = false;

  @override
  void initState() {
    super.initState();
    // Start the animation after a slight delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _startAnimation = true;
      });

      // Change background color after texts appear
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _changeBackgroundColor = true;
        });

        // Navigate to the next screen after the animation completes
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            // MaterialPageRoute(builder: (context) => const RootPage()),
            FadeRoute(
              page: const RootPage(),
            ),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _changeBackgroundColor ? Colors.white : Colors.red,
      body: Stack(
        children: [
          if (_startAnimation)
            Positioned(
              top: _changeBackgroundColor
                  ? 100
                  : MediaQuery.of(context).size.height / 2 - 60,
              left: 0,
              right: 0,
              child: SlideInUp(
                duration: const Duration(milliseconds: 1000),
                child: Column(
                  children: [
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/icon.png",
                            ),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.white,
                        ),
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeIn(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        'SmartAttend',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _changeBackgroundColor
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_startAnimation && _changeBackgroundColor)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: FadeIn(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 1000),
                child: const Text(
                  'Powered by Lucify',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          if (_changeBackgroundColor)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 40,
              left: 20,
              right: 20,
              child: FadeInUp(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 1000),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Your ID',
                        filled: true,
                        fillColor: Colors.grey[300]!,
                        border: InputBorder.none,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 35,
                          top: 20,
                          bottom: 20,
                        ),
                      ),
                    ),
                    vs(15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: InputBorder.none,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 35,
                          top: 20,
                          bottom: 20,
                        ),
                      ),
                      obscureText: true,
                    ),
                    vs(20),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {},
                            color: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Log in",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    vs(25),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    vs(25),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {},
                            // color: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              side: BorderSide(
                                color: Colors.black,
                                width: 1.8,
                              ),
                            ),
                            child: Text(
                              "Create new account",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
