import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookmarkButton extends StatelessWidget {
  final bool isBookmark;
  final bool isLoading;
  final Color color;
  final Function onPress;

  BookmarkButton(
      {Key key,
      @required this.isBookmark,
      this.isLoading,
      this.color,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading ?? false) {
      return Container(
        width: 48,
        height: 48,
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(color),
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    return IconButton(
      icon: Icon(
        isBookmark ? Icons.bookmark : Icons.bookmark_border,
        color: color,
      ),
      onPressed: onPress,
    );
  }
}
