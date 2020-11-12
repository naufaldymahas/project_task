import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/bloc/auth_bloc/index.dart';
import 'package:project_task/screen/home_screen.dart';
import 'package:project_task/screen/register_screen.dart';
import 'package:project_task/widget/auth_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    var formKey = GlobalKey<FormState>();
    List<Text> title = [
      Text(
        'Login',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      Text(
        'to MyApp',
        style: TextStyle(
            fontSize: 20,
            color: Colors.blueAccent[400],
            fontWeight: FontWeight.w600),
      )
    ];

    List<TextFormField> textFormField = [
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: email,
        decoration: InputDecoration(hintText: 'Email'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Email isn\'t empty';
          }
          return null;
        },
      ),
      TextFormField(
        controller: password,
        obscureText: true,
        decoration: InputDecoration(hintText: 'Password'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Password isn\'t empty';
          }
          return null;
        },
      )
    ];

    List<Widget> bottomWidget = [
      Text('Don\'t have any account? '),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.blueAccent[400]),
        ),
      )
    ];

    RaisedButton raisedButton = RaisedButton(
      color: Colors.blueAccent[400],
      onPressed: () {
        if (formKey.currentState.validate()) {
          context.read<AuthBloc>().add(
              AuthEventFetchUser(email: email.text, password: password.text));
        }
      },
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateIsLogin) {
            email.clear();
            password.clear();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomeScreen(state.user)));
          } else if (state is AuthStateLoginUnauthorized) {
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red[800],
                content: Text('Email/password wrong')));
          } else if (state is AuthStateFailed) {
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red[800],
                content: Text('Something wrong')));
          }
        },
        child: AuthWidget(
          title: title,
          textFormField: textFormField,
          bottomWidget: bottomWidget,
          raisedButton: raisedButton,
          formKey: formKey,
        ),
      ),
    );
  }
}
