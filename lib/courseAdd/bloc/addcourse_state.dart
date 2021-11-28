//part of 'login_bloc.dart';

part of 'addcourse_bloc.dart';

class AddCourseState extends Equatable {
  const AddCourseState({
    this.courseName = const Name.pure(),
    this.courseNumber = const Name.pure(),
    this.courseDescription = const Name.pure(),
    this.status = FormzStatus.pure,
  });

  final Name courseName;
  final Name courseNumber;
  final Name courseDescription;
  final FormzStatus status;

  AddCourseState copyWith({
    Name? courseName,
    Name? courseNumber,
    Name? courseDescription,
    FormzStatus? status,
  }) {
    return AddCourseState(
      courseName: courseName ?? this.courseName,
      courseNumber: courseNumber ?? this.courseNumber,
      courseDescription: courseDescription ?? this.courseDescription,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [courseName, courseNumber, courseDescription, status];
}
