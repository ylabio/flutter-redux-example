import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_redux_example/src/models/ticket_model.dart';

abstract class TicketAction {
  void onSelect(Ticket ticket);
  void onBookmark(Ticket ticket);
}

class TicketListItem extends StatelessWidget {
  final Ticket item;
  final TicketAction listener;

  TicketListItem({Key key, this.item, this.listener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      leading: Image.network(item.imageUrl),
      title: Text(item.title),
      trailing: IconButton(
        icon: Icon(Icons.bookmark),
        onPressed: () {
          listener.onBookmark(item);
        },
      ),
      onTap: () {
        listener.onSelect(item);
      },
    );
  }
}
