import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_attend/utils/colors.dart';
import 'package:smart_attend/utils/widgets.dart';
import 'package:animate_do/animate_do.dart';

import '../providers/socket_provider.dart';

class CodeEntryScreen extends StatefulWidget {
  const CodeEntryScreen({super.key});

  @override
  State<CodeEntryScreen> createState() => _CodeEntryScreenState();
}

class _CodeEntryScreenState extends State<CodeEntryScreen> {
  final txtController = TextEditingController();

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
      body: Consumer(builder: (context, ref, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                "Enter Code given by Professor",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              vs(20),
              TextField(
                controller: txtController,
                decoration: InputDecoration(
                  labelText: 'Enter Code',
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
              vs(30),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        try {
                          final socket = ref.watch(socketProvider);
                          socket.emit('attendance',
                              'New Attendance added for ${txtController.text} ');
                          log("emit attendance line");
                          _showSuccessDialog();
                        } catch (e) {
                          log("Error catch: $e");
                        }
                      },
                      color: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      )),
                      child: Text(
                        'Submit',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Powered by Lucify",
                    style: GoogleFonts.roboto(),
                  ),
                ],
              ),
              vs(25)
            ],
          ),
        );
      }),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SlideInUp(
          duration: const Duration(milliseconds: 300),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 70.0,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your attendance was successfully marked',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    minWidth: 250,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    color: AppColors.primary,
                    child: Text(
                      'Done',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
