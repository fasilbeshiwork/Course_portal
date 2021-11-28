import 'package:course_portal/courseAdd/view/course_add_update.dart';
import 'package:course_portal/courseList/bloc/course_list_bloc.dart';
import 'package:course_portal/courseList/bloc/course_list_event.dart';
import 'package:course_portal/courseList/bloc/course_list_state.dart';
import 'package:course_portal/data/models/course_.dart';
import 'package:course_portal/data/repositories/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseListPage extends StatelessWidget {
  const CourseListPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CourseListPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Courses'),
        ),
        body: RepositoryProvider(
          create: (context) => CourseRepository(),
          child: BlocProvider(
              create: (context) => CourseListBloc(
                    cR: context.read<CourseRepository>(),
                  )..add(const LoadCourses()),
              child: BlocBuilder<CourseListBloc, CourseListState>(
                  builder: (context, state) {
                if (state is CourseListLoadFailure) {
                  return const Center(
                      child: Text(
                          'Could not load Courses\nCheck your Connection'));
                }
                if (state is CourseListLoadingSuccess) {
                  final courses = state.courses;
                  return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                            color: Colors.red,
                          ),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                courses[index].courseName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              )),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: GestureDetector(
                                      //onTap: () => gotoInsertUpdate(context, product),
                                      onTap: () => gotoCourseAddUpdate(
                                          context, courses[index]),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        dialogDelete(context, courses[index]),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  )
                                ],
                              )),
                            ],
                          ),
                        ));
                      });
                }
                return const Center(
                  child: Text('Loding...'),
                );
                //const Center(child: CircularProgressIndicator());
              })
              //ListViewHome(),
              ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                //CourseAddUpdate.route()
                MaterialPageRoute(
                    builder: (context) =>
                        const CourseAddUpdate(course: Course(0, 'A', 'B', 'C'))
                    // InsertUpdateLayout(Product().setId(0))
                    ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void gotoCourseAddUpdate(BuildContext context, Course course) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CourseAddUpdate(course: course),
        ));
  }

  void dialogDelete(BuildContext context, Course course) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Delete'),
              content: Text('Are you sure wa"${course.courseName}"?'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    final clBloc = await context.read<CourseListBloc>()
                      ..add(DeleteCourse());
                    //_bloc.deleteProduct(product.getId());

                    //Navigator.pop(context);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('Deleted')),
                      );
                  },
                  child: const Text("Yes"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pop(context);
//Navigator.of(context).pop();
                  },
                  child: const Text("No"),
                ),
              ],
            ));
  }
}

class ListViewHome extends StatelessWidget {
  ListViewHome({Key? key}) : super(key: key);
  final titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.red,
            ),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                const Expanded(child: Text('CName')),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        //onTap: () => gotoInsertUpdate(context, product),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    ),
                    GestureDetector(
                      //onTap: () => dialogDelete(context, product),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 40,
                      ),
                    )
                  ],
                )),
              ],
            ),
          ));
        });
  }
}
