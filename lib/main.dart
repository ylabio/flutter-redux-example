import 'package:flutter/material.dart';

import 'package:flutter_redux_example/src/utils/router.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Redux Example',
      theme: ThemeData(),
      initialRoute: Router.loginRoute,
      routes: Router.routes(),
    );
  }
}
