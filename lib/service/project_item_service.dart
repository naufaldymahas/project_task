import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_task/common/base_url.dart';
import 'package:project_task/model/item.dart';
import 'package:project_task/model/project.dart';
import 'package:uuid/uuid.dart';

class ProjectItemService {
  Future<List<dynamic>> getProjectItem(String token) async {
    try {
      var res = await http.post(SYNC,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'token': token,
            'sync_token': '*',
            'resource_types': '[\"projects\", \"items\"]'
          }));
      var response = jsonDecode(res.body);
      List<dynamic> resProjects = response['projects'];
      List<dynamic> resItems = response['items'];
      List<Project> projects = [];
      List<Item> items = [];
      for (var i = 0; i < resProjects.length; i++) {
        if (resProjects[i]['is_deleted'] == 0) {
          projects.add(Project.fromJson(resProjects[i]));
        }
        for (var j = 0; j < resItems.length; j++) {
          if (resItems[i]['is_deleted'] == 0) {
            items.add(Item.fromJson(resItems[j]));
          }
          if (items[j].projectId == projects[i].id) {
            projects[i].items.add(items[j]);
          }
        }
      }
      return [projects, items];
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<dynamic>> addProject(String token, String name) async {
    try {
      var body = jsonEncode({
        "token": token,
        "commands": [
          {
            "type": "project_add",
            "temp_id": Uuid().v4(),
            "uuid": Uuid().v4(),
            "args": {"name": name}
          }
        ]
      });
      var res = await http.post(SYNC,
          body: body, headers: {"Content-Type": "application/json"});
      if (res.statusCode == 200) {
        return await getProjectItem(token);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Map<String, dynamic>> addItem(
      String token, String name, int projectId, String tempId) async {
    try {
      var body = jsonEncode({
        "token": token,
        "commands": [
          {
            "type": "item_add",
            "temp_id": tempId,
            "uuid": Uuid().v4(),
            "args": {"content": name, "project_id": projectId}
          }
        ]
      });
      var res = await http.post(SYNC,
          body: body, headers: {"Content-Type": "application/json"});
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
