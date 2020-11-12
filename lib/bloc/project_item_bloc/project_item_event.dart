import 'package:flutter/material.dart';

class ProjectItemEvent {}

class ProjectItemEventFetch extends ProjectItemEvent {
  final String token;
  ProjectItemEventFetch(this.token);
}

class ProjectItemAddProject extends ProjectItemEvent {
  final String token;
  final String name;
  ProjectItemAddProject({@required this.token, @required this.name});
}

class ProjectItemAddItem extends ProjectItemEvent {
  final String token;
  final int projectId;
  final String content;
  ProjectItemAddItem(
      {@required this.token, @required this.projectId, @required this.content});
}
