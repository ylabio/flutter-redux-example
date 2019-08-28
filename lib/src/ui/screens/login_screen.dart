import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_redux_example/src/store/app_state.dart';
import 'package:flutter_redux_example/src/ui/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        child: Column(
          children: <Widget>[
            SizedBox(height: 75),
            Icon(
              Icons.lock,
              color: Colors.blue,
              size: 125,
            ),
            SizedBox(height: 25),
            StoreConnector<AppState, LoginFormViewModel>(
              converter: (store) => LoginFormViewModel.fromStore(store),
              builder: (_, viewModel) {
                return LoginForm(viewModel: viewModel);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
