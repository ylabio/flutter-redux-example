import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_redux_example/src/models/ticket_model.dart';
import 'package:flutter_redux_example/src/utils/styles.dart';

abstract class TicketAction {
  void select(Ticket ticket);
  void bookmark(Ticket ticket);
}

class TicketListItem extends StatelessWidget {
  final Ticket item;
  final bool isActionLoading;
  final TicketAction listener;

  TicketListItem({Key key, this.item, this.isActionLoading, this.listener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      leading: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Image.network(item.imageUrl),
      ),
      title:
          Text((item.title ?? '').toUpperCase(), style: Styles.itemListTitle),
      subtitle: Text('tap to open...'),
      trailing: IconButton(
        icon: Icon(
          item.isBookmark ? Icons.bookmark : Icons.bookmark_border,
          color: Styles.nightBlack,
        ),
        onPressed: () {
          listener.bookmark(item);
        },
      ),
      onTap: isActionLoading
          ? null
          : () {
              listener.select(item);
            },
    );
  }
}
