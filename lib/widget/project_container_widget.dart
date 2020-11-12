import 'package:flutter/material.dart';
import 'package:project_task/bloc/project_item_bloc/index.dart';
import 'package:project_task/model/project.dart';
import 'package:project_task/screen/item_screen.dart';

class ProjectContainer extends StatelessWidget {
  final List<Project> projects;
  final ProjectItemBloc _projectItemBloc;
  final String token;
  TextEditingController title = TextEditingController();
  ProjectContainer(
      {@required this.projects,
      @required ProjectItemBloc projectItemBloc,
      @required this.token})
      : _projectItemBloc = projectItemBloc;
  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  ListView _build(BuildContext context) {
    var i = 0;
    List<List<Widget>> rows = [];
    List<Widget> listView = [];

    while (projects.length > i) {
      List<Widget> c = List();
      for (var j = 0; j < 2; j++) {
        if (i < projects.length) {
          var k = i;
          c.add(GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ItemScreen(
                        items: projects[k].items,
                        token: token,
                        projectItemBloc: _projectItemBloc,
                        projectId: projects[k].id,
                      )));
            },
            child: Container(
              height: 180,
              width: 180,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    projects[i].name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(projects[i].items.length.toString() + ' tasks')
                ],
              ),
            ),
          ));
        }
        i++;
      }
      if (c.length == 1) {
        c.add(_addProject(context));
      }
      rows.add(c);
      if (c.length == 2 && i == projects.length) {
        rows.add([_addProject(context)]);
      }
    }

    if (projects.length == 0) {
      rows.add([_addProject(context)]);
    }

    rows.forEach((r) {
      listView.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: r,
      ));
      listView.add(SizedBox(height: 15));
    });
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 17),
      children: listView,
    );
  }

  GestureDetector _addProject(BuildContext context) => GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                    actions: [
                      RaisedButton(
                        color: Colors.blueAccent[400],
                        onPressed: () {
                          if (title.text.trim().length != 0) {
                            _projectItemBloc.add(ProjectItemAddProject(
                                token: token, name: title.text));
                            Navigator.pop(context);
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Input project name properly'),
                              backgroundColor: Colors.red[800],
                            ));
                          }
                        },
                        child: Text('Submit'),
                      )
                    ],
                    title: Text('Add new project'),
                    content: TextField(
                      controller: title,
                    )));
      },
      child: Container(
        height: 180,
        width: 180,
        color: Colors.white,
        child: Center(
          child: Text(
            '+',
            style: TextStyle(fontSize: 36),
          ),
        ),
      ));
}
