import 'package:flutter/material.dart';

class AuthEvent {}

class AuthEventFetchUser extends AuthEvent {
  final String email;
  final String password;
  AuthEventFetchUser({@required this.email, @required this.password});
}

class AuthEventRegisterUser extends AuthEvent {
  final String email;
  final String fullname;
  final String password;
  AuthEventRegisterUser({@required this.email, @required this.fullname, @required this.password});
}

class AuthEventNotRegister extends AuthEvent {}