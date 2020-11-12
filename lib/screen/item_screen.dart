import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/bloc/project_item_bloc/index.dart';
import 'package:project_task/model/item.dart';

class ItemScreen extends StatelessWidget {
  final List<Item> items;
  final int projectId;
  final String token;
  final ProjectItemBloc _projectItemBloc;
  ItemScreen(
      {@required this.items,
      @required this.projectId,
      @required this.token,
      @required ProjectItemBloc projectItemBloc})
      : _projectItemBloc = projectItemBloc;
  @override
  Widget build(BuildContext context) {
    var content = TextEditingController();
    return BlocBuilder<ProjectItemBloc, ProjectItemState>(
        builder: (context, state) {
      if (state is ProjectItemStateAddItemDone) {
        if (content.text.isNotEmpty) {
          items.add(Item(
              content: content.text,
              id: state.id,
              isDeleted: 0,
              projectId: projectId));
          _projectItemBloc.add(ProjectItemEventFetch(token));
        }
        content.clear();
      }
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                          actions: [
                            RaisedButton(
                              color: Colors.blueAccent[400],
                              onPressed: () {
                                if (content.text.trim().length != 0) {
                                  context.read<ProjectItemBloc>().add(
                                      ProjectItemAddItem(
                                          projectId: projectId,
                                          token: token,
                                          content: content.text));
                                  Navigator.pop(context);
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Input item name properly'),
                                    backgroundColor: Colors.red[800],
                                  ));
                                }
                              },
                              child: Text('Submit'),
                            )
                          ],
                          title: Text('Add new item'),
                          content: TextField(
                            controller: content,
                          )));
            },
            child: Text(
              '+',
              style: TextStyle(fontSize: 30),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.blueAccent[400],
            title: Text(
              'Tasks',
            ),
          ),
          backgroundColor: Colors.grey[100],
          body: items.length > 0
              ? BlocListener<ProjectItemBloc, ProjectItemState>(
                  listener: (context, state) {
                    if (state is ProjectItemStateAddItemDone) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Success adding new item'),
                        backgroundColor: Colors.blueAccent[400],
                      ));
                    }
                  },
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        return Container(
                          color: Colors.white,
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Text(items[i].content),
                        );
                      }),
                )
              : Center(
                  child: Text('No tasks in this project'),
                ));
    });
  }
}
