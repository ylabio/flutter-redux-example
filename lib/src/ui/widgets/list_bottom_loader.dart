import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListBottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
