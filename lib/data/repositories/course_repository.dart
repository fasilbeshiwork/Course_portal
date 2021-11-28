import 'package:course_portal/data/dataProviders/course_api_provider.dart';
import 'package:course_portal/data/models/course_.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  final courseApiProvider = CourseApiProvider();
  Future<List<Course>> loadCourseList() async {
    return courseApiProvider.loadCourseList(http.Client());
  }

  Future<Course> saveCourse({
    required String cName,
    required String cNumber,
    required String cDescription,
  }) async {
    print('tring to save');
    final course = courseApiProvider.saveCourse(
        cName, cNumber, cDescription, http.Client());
    return course;
  }
}
