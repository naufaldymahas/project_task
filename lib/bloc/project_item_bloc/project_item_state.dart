import 'package:flutter/material.dart';
import 'package:project_task/model/item.dart';
import 'package:project_task/model/project.dart';

class ProjectItemState {}

class ProjectItemStateLoading extends ProjectItemState {}

class ProjectItemStateFetch extends ProjectItemState {
  final List<Project> projects;
  final List<Item> items;
  ProjectItemStateFetch({@required this.projects, @required this.items});
}

class ProjectItemStateFetchFailed extends ProjectItemState {}

class ProjectItemStateAddItemDone extends ProjectItemState {
  final int id;
  ProjectItemStateAddItemDone(this.id);
}

class ProjectItemStateDone extends ProjectItemState {}
