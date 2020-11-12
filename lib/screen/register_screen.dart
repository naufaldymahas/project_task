import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/bloc/auth_bloc/index.dart';
import 'package:project_task/screen/home_screen.dart';
import 'package:project_task/screen/login_screen.dart';
import 'package:project_task/widget/auth_widget.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var fullname = TextEditingController();
    var password = TextEditingController();
    var repassword = TextEditingController();
    var formKey = GlobalKey<FormState>();
    List<Text> title = [
      Text(
        'Create your',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      Text(
        'account',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      )
    ];

    List<TextFormField> textFormField = [
      TextFormField(
        controller: fullname,
        decoration: InputDecoration(hintText: 'Fullname'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Fullname isn\'t empty';
          }
          return null;
        },
      ),
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
          } else if (value != repassword.text) {
            return 'Password different with retype password';
          }
          return null;
        },
      ),
      TextFormField(
        controller: repassword,
        obscureText: true,
        decoration: InputDecoration(hintText: 'Retype Password'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Retype Password isn\'t empty';
          } else if (value != password.text) {
            return 'Password different with retype password';
          }
          return null;
        },
      )
    ];

    List<Widget> bottomWidget = [
      Text('Have an account? '),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Text(
          'Login',
          style: TextStyle(color: Colors.blueAccent[400]),
        ),
      )
    ];

    RaisedButton raisedButton = RaisedButton(
      color: Colors.blueAccent[400],
      onPressed: () {
        if (formKey.currentState.validate()) {
          context.read<AuthBloc>().add(AuthEventRegisterUser(
              email: email.text,
              fullname: fullname.text,
              password: password.text));
        }
      },
      child: Text(
        'Register',
        style: TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateIsLogin) {
            email.clear();
            fullname.clear();
            password.clear();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomeScreen(state.user)));
          } else if (state is AuthStateUserAlreadyExist) {
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red[800],
                content: Text('User already exists')));
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
