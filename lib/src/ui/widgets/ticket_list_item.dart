import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_redux_example/src/models/ticket_model.dart';
import 'package:flutter_redux_example/src/ui/widgets/bookmark_button.dart';
import 'package:flutter_redux_example/src/utils/styles.dart';

abstract class TicketAction {
  void select(Ticket ticket);
  void bookmark(Ticket ticket);
}

class TicketListItem extends StatelessWidget {
  final Ticket item;
  final String actionTicketId;
  final bool isActionLoading;
  final TicketAction listener;

  TicketListItem(
      {Key key,
      this.item,
      this.actionTicketId,
      this.isActionLoading,
      this.listener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      leading: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          width: 75,
          height: double.infinity,
          child: Image.network(
            item.imageUrl,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              );
            },
          ),
        ),
      ),
      title:
          Text((item.title ?? '').toUpperCase(), style: Styles.itemListTitle),
      subtitle: Text('tap to open...'),
      trailing: BookmarkButton(
        isBookmark: item.isBookmark,
        isLoading: isActionLoading && actionTicketId == item.id,
        color: Styles.nightBlack,
        onPress: () => listener.bookmark(item),
      ),
      onTap: isActionLoading
          ? null
          : () {
              listener.select(item);
            },
    );
  }
}
