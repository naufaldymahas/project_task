import 'package:flutter/material.dart';

class Item {
  final int id;
  final int projectId;
  final String content;
  final int isDeleted;
  Item({@required this.id, @required this.projectId, @required this.content, @required this.isDeleted});

  factory Item.fromJson(Map<String, dynamic> payload) => Item(
      id: payload['id'],
      projectId: payload['project_id'],
      content: payload['content'],
      isDeleted: payload['is_deleted']);
}
