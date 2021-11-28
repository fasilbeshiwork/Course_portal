import 'package:course_portal/data/models/course_.dart';
import 'package:equatable/equatable.dart';

class CourseListState extends Equatable {
  final List<Course> courses = [];

  @override
  List<Object> get props => [];
}

class CourseListLoading extends CourseListState {}

class CourseListLoadingSuccess extends CourseListState {
  final List<Course> courses;
  CourseListLoadingSuccess([this.courses = const []]);
}

class CourseListLoadFailure extends CourseListState {}
