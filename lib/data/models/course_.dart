import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final int id;
  final String courseName;
  final String courseNumber;
  final String courseDescription;

  const Course(
      this.id, this.courseName, this.courseNumber, this.courseDescription);

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(json['id'], json['course_name'], json['course_number'],
        json['course_description']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'course_name': courseName,
        'course_number': courseNumber,
        'course_description': courseDescription,
      };

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
