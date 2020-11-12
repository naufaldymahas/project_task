import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/bloc/project_item_bloc/index.dart';
import 'package:project_task/model/user.dart';
import 'package:project_task/service/project_item_service.dart';
import 'package:project_task/widget/project_container_widget.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProjectItemBloc _projectItemBloc;

  @override
  void initState() {
    super.initState();
    _projectItemBloc = ProjectItemBloc(ProjectItemService());
    _projectItemBloc.add(ProjectItemEventFetch(widget.user.token));
  }

  @override
  dispose() {
    super.dispose();
    _projectItemBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        title: Text(
          'Projects',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<ProjectItemBloc, ProjectItemState>(
          cubit: _projectItemBloc,
          builder: (context, state) {
            if (state is ProjectItemStateFetch) {
              return ProjectContainer(
                projects: state.projects,
                projectItemBloc: _projectItemBloc,
                token: widget.user.token,
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
