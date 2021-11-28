import 'package:equatable/equatable.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();
}

class LoadCourses extends CourseListEvent {
  const LoadCourses();

  @override
  List<Object> get props => [];
}

class ViewCourseDetail extends CourseListEvent {
  const ViewCourseDetail();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UpdateCourseDetail extends CourseListEvent {
  const UpdateCourseDetail();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteCourse extends CourseListEvent {
  const DeleteCourse();

  @override
  List<Object?> get props => throw UnimplementedError();
}
