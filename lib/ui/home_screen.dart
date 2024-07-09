import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_attend/ui/course_details_page.dart';
import 'package:smart_attend/ui/test.dart';
import 'package:smart_attend/utils/colors.dart';
import 'package:smart_attend/utils/fade_route.dart';
import 'package:smart_attend/utils/widgets.dart';
import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authProvider);
    final courses = ref.watch(coursesProvider);
    final selectedCourse = ref.watch(selectedCourseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SmartAttend',
          style: GoogleFonts.roboto(
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(FadeRoute(page: const TestSocketPage()));
              },
              icon: const Icon(Icons.system_security_update_good_sharp)),
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
      body: Center(
        child: isAuthenticated
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "Courses List",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    vs(15),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: courses.map((course) {
                        final isCardSelected = selectedCourse?.id == course.id;
                        log("Selected:$isCardSelected");
                        return SlideInRight(
                          child: Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {
                                    ref
                                        .read(selectedCourseProvider.notifier)
                                        .state = course;
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: isCardSelected
                                          ? Colors.green[100]
                                          : Colors.white,
                                    ),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          course.name,
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        hs(10),
                                        if (isCardSelected)
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green,
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Hero(
                            tag: "MarkAttendanceBtn",
                            child: SlideInRight(
                              child: MaterialButton(
                                onPressed: selectedCourse == null
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CourseDetailsScreen(
                                                    course: selectedCourse),
                                          ),
                                        );
                                      },
                                color: AppColors.primary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                )),
                                child: Text(
                                  'Mark Attendance',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    vs(80),
                    Text(
                      "Powered by Lucify",
                      style: GoogleFonts.roboto(),
                    ),
                    vs(25)
                  ],
                ),
              )
            : const Text('Not logged in'),
      ),
    );
  }
}
