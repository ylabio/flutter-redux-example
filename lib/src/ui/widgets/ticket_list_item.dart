import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_redux_example/src/models/ticket_model.dart';

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
      leading: Image.network(item.imageUrl),
      title: Text(item.title),
      trailing: IconButton(
        icon: Icon(item.isBookmark ? Icons.bookmark : Icons.bookmark_border),
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
