import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_task/common/base_url.dart';
import 'package:project_task/model/user.dart';

class AuthService {
  Future<http.Response> login(
      {@required String email, @required String password}) async {
    try {
      return await http.post(LOGIN,
          body: jsonEncode({'email': email, 'password': password}),
          headers: {"Content-Type": "application/json"});
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> register(
      {@required String email,
      @required String password,
      @required String fullname}) async {
    try {
      return await http.post(REGISTER,
          body: jsonEncode(
              {'email': email, 'password': password, 'full_name': fullname}),
          headers: {"Content-Type": "application/json"});
    } catch (e) {
      print(e);
      return null;
    }
  }
}
