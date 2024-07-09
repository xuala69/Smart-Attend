import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_attend/models/course.dart';
import 'package:smart_attend/utils/colors.dart';
import 'package:smart_attend/utils/widgets.dart';

import 'face_detection_screen.dart';

class CourseDetailsScreen extends ConsumerStatefulWidget {
  final Course course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  CourseDetailsScreenState createState() => CourseDetailsScreenState();
}

class CourseDetailsScreenState extends ConsumerState<CourseDetailsScreen> {
  String _selectedFilter = 'Last 30 days';
  final List<String> _filters = ['Last 30 days', 'Last 90 days', 'Last month'];

  // Dummy attendance history
  final List<Map<String, String>> _attendanceHistory = [
    {'date': '12 June 2024', 'day': 'Monday', 'status': 'Present'},
    {'date': '13 June 2024', 'day': 'Tuesday', 'status': 'Absent'},
    {'date': '14 June 2024', 'day': 'Wednesday', 'status': 'Present'},
    {'date': '15 June 2024', 'day': 'Thursday', 'status': 'Present'},
    {'date': '16 June 2024', 'day': 'Friday', 'status': 'Present'},
    // Add more dummy data
  ];

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vs(15),
            Text(
              widget.course.name,
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            vs(10),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                ),
                hs(5),
                Text(
                  "LH 121",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hs(25),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.schedule_rounded,
                    color: Colors.white,
                  ),
                ),
                hs(5),
                Text(
                  "11:00 AM",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            vs(30),
            Row(
              children: [
                Expanded(
                  child: Hero(
                    tag: "MarkAttendanceBtn",
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MarkAttendancePage(),
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
                        'Mark Attendance',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            vs(50),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Attendance History \nand Statistics",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFilter = newValue!;
                            // Update the attendance history based on the selected filter
                          });
                        },
                        items: _filters
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            vs(20),
            historyLine(
              date: "Date",
              day: "Day",
              attendance: "Attendance",
              cardColor: getColor(null),
              toBold: true,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _attendanceHistory.length,
                itemBuilder: (context, index) {
                  final history = _attendanceHistory[index];
                  return historyLine(
                    date: history['date'] ?? "",
                    day: history['day'] ?? "",
                    attendance: history['status'] ?? "",
                    cardColor: getColor(history['status']),
                    toBold: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget historyLine({
    required String date,
    required String day,
    required String attendance,
    required Color cardColor,
    required bool toBold,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              date,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: toBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              day,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: toBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              attendance,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: toBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(String? attendance) {
    if (attendance == null) {
      return Colors.grey[300]!;
    }
    if (attendance.toLowerCase() == "present") {
      return Colors.green[100]!;
    } else {
      return Colors.red[100]!;
    }
  }
}
