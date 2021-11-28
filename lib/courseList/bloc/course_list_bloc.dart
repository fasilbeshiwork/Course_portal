import 'package:course_portal/courseList/bloc/course_list_event.dart';
import 'package:course_portal/courseList/bloc/course_list_state.dart';
import 'package:course_portal/data/models/course_.dart';
import 'package:course_portal/data/repositories/course_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc({required CourseRepository cR})
      : _courseRepository = cR,
        super(CourseListState()) {
    on<LoadCourses>(_onLoadCourses);
    on<UpdateCourseDetail>(_onUpdateCourseDetail);
    on<ViewCourseDetail>(_onViewCourseDetail);
    on<DeleteCourse>(_onDeleteCourse);
  }
  @override
  void onTransition(Transition<CourseListEvent, CourseListState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  final CourseRepository _courseRepository;

  void _onLoadCourses(LoadCourses event, Emitter<CourseListState> emit) async {
    emit(CourseListLoading());
    try {
      print('tying');
      final List<Course> courses = await _courseRepository.loadCourseList();
      print('CNUMBERS' + courses[2].courseName);
      emit(CourseListLoadingSuccess(courses));
    } catch (e) {
      print('EEEE' + e.toString());
      emit(CourseListLoadFailure());
    }
  }

  void _onUpdateCourseDetail(
      UpdateCourseDetail event, Emitter<CourseListState> emit) {}
  void _onViewCourseDetail(
      ViewCourseDetail event, Emitter<CourseListState> emit) {}
  void _onDeleteCourse(DeleteCourse event, Emitter<CourseListState> emit) {}
}
