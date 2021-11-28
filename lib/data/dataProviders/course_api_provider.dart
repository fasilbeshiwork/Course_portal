import 'dart:convert';

import 'package:course_portal/data/models/course_.dart';
import 'package:course_portal/utilities/base_url.dart';
import 'package:http/http.dart' as http;

class CourseApiProvider {
  Future<Course> saveCourse(String cName, String cNumber, String cDescription,
      http.Client client) async {
    var url = Uri.parse(baseUrl + "/api/course");
    final response = await client.post(url, body: {
      'course_name': cName,
      'course_number': cNumber,
      'course_description': cDescription
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      print(responseJson.toString());
      return Course.fromJson(responseJson['course']);
    } else {
      throw Exception('Add' + response.body);
    }
  }

  Future<List<Course>> loadCourseList(http.Client client) async {
    var url = Uri.parse(baseUrl + "/api/course");
    final response = await client.get(url);
    //print(jsonDecode(response.body)['courses']);
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    /* final crs =
        (jsonDecode(response.body)['courses'] as List<dynamic>).map((c) {
      return Course.fromJson(c);
    }).toList();
      */
    return (jsonDecode(response.body)['courses'] as List)
        .map((course) => Course.fromJson(course))
        .toList();
    //return myc;
  }

  // Future<Course> getCourseDetail() async {}

  //Future<Course> DeleteCourse() async {}
  //Future<Course> UpdateCourse() async {}
}
