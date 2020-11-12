import 'package:flutter/material.dart';
import 'package:project_task/model/item.dart';

class Project {
  final int id;
  final int isDeleted;
  final String name;
  List<Item> items;
  Project(
      {@required this.id,
      @required this.isDeleted,
      @required this.name,
      this.items});

  factory Project.fromJson(Map<String, dynamic> payload) => Project(
      id: payload['id'],
      isDeleted: payload['is_deleted'],
      name: payload['name'],
      items: []);
}
