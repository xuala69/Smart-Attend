import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_attend/models/course.dart';

final coursesProvider = StateProvider<List<Course>>((ref) {
  return [
    Course(id: '1', name: 'MTL 100'),
    Course(id: '2', name: 'PYL 100'),
    Course(id: '3', name: 'CML 100'),
    Course(id: '4', name: 'APL 105'),
    Course(id: '5', name: 'NEN 100'),
  ];
});

final selectedCourseProvider = StateProvider<Course?>((ref) {
  return null;
});
