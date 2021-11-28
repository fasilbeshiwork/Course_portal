import 'package:course_portal/courseAdd/bloc/addcourse_bloc.dart';
import 'package:course_portal/data/models/course_.dart';
import 'package:course_portal/data/repositories/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CourseAddUpdate extends StatelessWidget {
  const CourseAddUpdate({Key? key, required this.course}) : super(key: key);
  final Course course;
  /* static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CourseAddUpdate());
  }*/

  @override
  Widget build(BuildContext context) {
    String title = '';
    if (course.id == 0) {
      title = "    ADD";
    } else {
      title = "Update";
      // nameController.text = product.getName();
      //qtyController.text = product.getQty().toString();
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Course'),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
            child: RepositoryProvider(
              create: (context) => CourseRepository(),
              child: BlocProvider(
                  create: (context) =>
                      AddCourseBloc(cR: context.read<CourseRepository>()),
                  child: BlocListener<AddCourseBloc, AddCourseState>(
                      listener: (context, state) {
                        if (state.status.isSubmissionInProgress) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(content: Text('Submitting...')),
                            );
                        }
                        if (state.status.isSubmissionSuccess) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          showDialog<void>(
                            context: context,
                            builder: (_) => SuccessDialog(),
                          );
                          /* Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );*/
                        }
                        if (state.status.isSubmissionFailure) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          showDialog<void>(
                            context: context,
                            builder: (_) => FailureDialog(),
                          );
                        }
                      },
                      child: ListView(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Card(
                            child: Column(
                              children: [
                                CourseNameInput(iValue: course.courseName),
                                CourseNumberInput(iValue: course.courseNumber),
                                CourseDescriptionInput(
                                    iValue: course.courseDescription),
                                const SizedBox(
                                  height: 25,
                                ),
                                const AddCourseButton()
                              ],
                            ),
                          ),
                        ],
                      ))),
            )),
      ),
    );
  }
}

class CourseNameInput extends StatelessWidget {
  const CourseNameInput({Key? key, required this.iValue}) : super(key: key);
  final String iValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseBloc, AddCourseState>(
      buildWhen: (previous, current) =>
          previous.courseName != current.courseName,
      builder: (context, state) {
        return TextFormField(
          initialValue: iValue, //state.courseName.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.book),
            labelText: 'Name',
            helperText: ' e.g. Java',
            errorText: state.courseName.invalid
                ? 'Please ensure the Name entered is valid'
                : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context.read<AddCourseBloc>().add(CourseNameChanged(value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class CourseNumberInput extends StatelessWidget {
  const CourseNumberInput({Key? key, required this.iValue}) : super(key: key);
  final String iValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseBloc, AddCourseState>(
      buildWhen: (previous, current) =>
          previous.courseNumber != current.courseNumber,
      builder: (context, state) {
        return TextFormField(
          initialValue: iValue, //state.courseNumber.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Course No',
            helperText: ' e.g. ITSE 4312 ',
            errorText: state.courseNumber.invalid ? 'Ivalid data' : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context.read<AddCourseBloc>().add(CourseNumberChanged(value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class CourseDescriptionInput extends StatelessWidget {
  const CourseDescriptionInput({Key? key, required this.iValue})
      : super(key: key);
  final String iValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseBloc, AddCourseState>(
      buildWhen: (previous, current) =>
          previous.courseDescription != current.courseDescription,
      builder: (context, state) {
        return TextFormField(
          initialValue: iValue, //state.courseDescription.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.subject),
            labelText: 'Descripion',
            helperText: ' e.g. This course is...',
            errorText: state.courseDescription.invalid ? 'Invalid data' : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context.read<AddCourseBloc>().add(CourseDescriptionChanged(value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class AddCourseButton extends StatelessWidget {
  const AddCourseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseBloc, AddCourseState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () =>
              context.read<AddCourseBloc>().add(const AddCourseFormSubmitted()),
          child: const Text('Submit'),
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: const <Widget>[
                Icon(Icons.info),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              //onPressed: () {},
              //onPressed: () => Navigator.of(context).pop(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FailureDialog extends StatelessWidget {
  const FailureDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: const <Widget>[
                Icon(Icons.info),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Submision Error!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              ////onPressed: () {},
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
