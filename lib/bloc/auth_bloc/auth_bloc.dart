import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/bloc/auth_bloc/auth_event.dart';
import 'package:project_task/bloc/auth_bloc/auth_state.dart';
import 'package:project_task/model/user.dart';
import 'package:project_task/service/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc(this.authService) : super(AuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    yield AuthStateIsLoading();
    if (event is AuthEventFetchUser) {
      final res =
          await authService.login(email: event.email, password: event.password);
      final response = jsonDecode(res.body);
      if (res.statusCode == 200) {
        yield AuthStateIsLogin(user: User.fromJson(response));
        return;
      } else if (res.statusCode == 401) {
        yield AuthStateLoginUnauthorized();
        return;
      }
      yield AuthStateFailed();
    } else if (event is AuthEventRegisterUser) {
      final res = await authService.register(
          email: event.email,
          password: event.password,
          fullname: event.fullname);
      final response = jsonDecode(res.body);
      if (res.statusCode == 200) {
        yield AuthStateIsLogin(user: User.fromJson(response));
        return;
      } else {
        if (response['error_tag'] == 'ALREADY_REGISTERED') {
          yield AuthStateUserAlreadyExist();
          return;
        }
      }
      yield AuthStateFailed();
    }
  }
}
