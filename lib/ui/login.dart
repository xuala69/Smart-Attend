import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_attend/providers/auth_provider.dart';
import 'package:smart_attend/utils/colors.dart';
import 'package:smart_attend/utils/widgets.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            vs(40),
            Card(
              elevation: 15,
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
            vs(15),
            Text(
              "SmartAttend",
              style: GoogleFonts.roboto(
                color: AppColors.primary,
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            TextField(
              controller: emailController,
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
              controller: passwordController,
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
                    onPressed: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      ref.read(authProvider.notifier).login(email, password);
                    },
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
            const Spacer(),
            Text(
              "Powered by Lucify",
              style: GoogleFonts.roboto(),
            ),
            vs(25)
          ],
        ),
      ),
    );
  }
}
