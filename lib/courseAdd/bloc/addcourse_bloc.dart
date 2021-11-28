import 'package:course_portal/data/repositories/course_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:course_portal/data/models/name.dart';
import 'package:formz/formz.dart';

import 'package:equatable/equatable.dart';
part 'addcourse_event.dart';
part 'addcourse_state.dart';

class AddCourseBloc extends Bloc<AddCourseEvent, AddCourseState> {
  AddCourseBloc({
    required CourseRepository cR,
  })  : _courseRepository = cR,
        super(const AddCourseState()) {
    on<CourseNameChanged>(_onCourseNameChanged);
    on<CourseNumberChanged>(_onCourseNumberChanged);
    on<CourseDescriptionChanged>(_onCourseDescriptionChanged);
    on<AddCourseFormSubmitted>(_onAddCourseFormSubmitted);
  }
  final CourseRepository _courseRepository;
  @override
  void onTransition(Transition<AddCourseEvent, AddCourseState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  void _onCourseNameChanged(
    CourseNameChanged event,
    Emitter<AddCourseState> emit,
  ) {
    final courseName = Name.dirty(event.courseName);
    emit(state.copyWith(
      courseName: courseName,
      status: Formz.validate(
          [courseName, state.courseNumber, state.courseDescription]),
    ));
  }

  void _onCourseNumberChanged(
    CourseNumberChanged event,
    Emitter<AddCourseState> emit,
  ) {
    final courseNumber = Name.dirty(event.courseNumber);
    emit(state.copyWith(
      courseNumber: courseNumber,
      status: Formz.validate(
          [state.courseName, courseNumber, state.courseDescription]),
    ));
  }

  void _onCourseDescriptionChanged(
    CourseDescriptionChanged event,
    Emitter<AddCourseState> emit,
  ) {
    final courseDescription = Name.dirty(event.courseDescripion);
    emit(state.copyWith(
      courseDescription: courseDescription,
      status: Formz.validate(
          [state.courseName, state.courseNumber, courseDescription]),
    ));
  }

  void _onAddCourseFormSubmitted(
    AddCourseEvent event,
    Emitter<AddCourseState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        print('CCCCCCCCCCCCCCCCCCC');

        await _courseRepository.saveCourse(
            cName: state.courseName.value,
            cNumber: state.courseNumber.value,
            cDescription: state.courseDescription.value);

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        print('EEE' + e.toString());
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
