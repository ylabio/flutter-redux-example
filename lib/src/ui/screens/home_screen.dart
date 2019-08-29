import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux_example/src/store/app/app_state.dart';
import 'package:flutter_redux_example/src/store/auth/store.dart';

class HomeScreenViewModel {
  final AuthState authState;
  final Function onLogout;

  HomeScreenViewModel({this.authState, this.onLogout});

  static HomeScreenViewModel fromStore(Store<AppState> store) {
    return HomeScreenViewModel(
      authState: store.state.authState,
      onLogout: (context) => store.dispatch(signout(context)),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final HomeScreenViewModel viewModel;

  HomeScreen({Key key, this.viewModel}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Icon(
          Icons.format_list_bulleted,
          color: Colors.black45,
          size: 125,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text('Home'),
      actions: <Widget>[
        StoreConnector<AppState, HomeScreenViewModel>(
          converter: (store) => HomeScreenViewModel.fromStore(store),
          builder: (_, viewModel) {
            return IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                viewModel.onLogout(context);
              },
            );
          },
        ),
      ],
    );
  }
}
