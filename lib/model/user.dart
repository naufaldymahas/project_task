import 'package:flutter/material.dart';

class User {
  final String fullname;
  final String token;
  User({@required this.fullname, @required this.token});
  factory User.fromJson(Map<String, dynamic> payload) =>
      User(fullname: payload["full_name"], token: payload["token"]);
}