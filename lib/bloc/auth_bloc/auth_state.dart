import 'package:flutter/material.dart';
import 'package:project_task/model/user.dart';

class AuthState {}

class AuthStateIsLogin extends AuthState {
  final User user;
  AuthStateIsLogin({@required this.user});
}

class AuthStateIsLoading extends AuthState {}

class AuthStateFailed extends AuthState {}

class AuthStateLoginUnauthorized extends AuthState {}

class AuthStateUserAlreadyExist extends AuthState {}