import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux_example/src/store/app_state.dart';
import 'package:flutter_redux_example/src/store/auth/store.dart';

class LoginFormViewModel {
  final AuthState authState;
  final Function onLogin;

  LoginFormViewModel({this.authState, this.onLogin});

  static LoginFormViewModel fromStore(Store<AppState> store) {
    return LoginFormViewModel(
      authState: store.state.authState,
      onLogin: (context, login, password) =>
          store.dispatch(signin(context, login, password)),
    );
  }
}

class LoginForm extends StatefulWidget {
  final LoginFormViewModel viewModel;

  LoginForm({Key key, this.viewModel}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authState = widget.viewModel.authState;

    if (_authState.token == null && _authState.isLoading) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Form(
      child: Padding(
        padding: const EdgeInsets.only(left: 45, right: 45),
        child: Column(
          children: [
            Text('Sign in'),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                if (!_authState.isLoading) {
                  _onLoginPressed();
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                if (!_authState.isLoading) {
                  _onLoginPressed();
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: !_authState.isLoading ? _onLoginPressed : null,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Login',
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            SizedBox(height: 15),
            Text(
              _authState.error != null ? _authState.error.description : '',
              style: TextStyle(color: Colors.red),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: _authState.isLoading ? CircularProgressIndicator() : null,
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginPressed() {
    widget.viewModel
        .onLogin(context, _usernameController.text, _passwordController.text);
  }
}
