import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/bloc/auth_bloc/auth_bloc.dart';
import 'package:project_task/bloc/project_item_bloc/index.dart';
import 'package:project_task/screen/login_screen.dart';
import 'package:project_task/service/auth_service.dart';
import 'package:project_task/service/project_item_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (BuildContext context) => AuthBloc(AuthService())),
          BlocProvider<ProjectItemBloc>(
              create: (BuildContext context) =>
                  ProjectItemBloc(ProjectItemService()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        ));
  }
}
