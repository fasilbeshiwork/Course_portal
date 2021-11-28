part of 'addcourse_bloc.dart';

abstract class AddCourseEvent extends Equatable {
  const AddCourseEvent();

  @override
  List<Object> get props => [];
}

class CourseNameChanged extends AddCourseEvent {
  const CourseNameChanged(this.courseName);

  final String courseName;

  @override
  List<Object> get props => [courseName];
}

class CourseNumberChanged extends AddCourseEvent {
  const CourseNumberChanged(this.courseNumber);

  final String courseNumber;

  @override
  List<Object> get props => [courseNumber];
}

class CourseDescriptionChanged extends AddCourseEvent {
  const CourseDescriptionChanged(this.courseDescripion);

  final String courseDescripion;

  @override
  List<Object> get props => [courseDescripion];
}

class AddCourseFormSubmitted extends AddCourseEvent {
  const AddCourseFormSubmitted();
}
