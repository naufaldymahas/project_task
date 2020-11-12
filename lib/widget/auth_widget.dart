import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/bloc/auth_bloc/index.dart';

class AuthWidget extends StatelessWidget {
  final List<Text> title;
  final List<TextFormField> textFormField;
  final List<Widget> bottomWidget;
  final RaisedButton raisedButton;
  final GlobalKey<FormState> formKey;
  AuthWidget(
      {@required this.title,
      @required this.textFormField,
      @required this.bottomWidget,
      @required this.raisedButton,
      @required this.formKey});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => state is AuthStateIsLoading
              ? Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox(),
        ),
        SafeArea(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            ...title,
            SizedBox(
              height: 30,
            ),
            Form(
              key: formKey,
              child: Column(
                children: textFormField,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            raisedButton,
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bottomWidget,
            ),
          ],
        )),
      ],
    );
  }
}
