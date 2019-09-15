import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_redux_example/src/ui/widgets/list_bottom_loader.dart';
import 'package:flutter_redux_example/src/ui/widgets/ticket_list_item.dart';
import 'package:flutter_redux_example/src/models/ticket_model.dart';
import 'package:flutter_redux_example/src/utils/app_settings.dart';

class TicketList extends StatefulWidget {
  final List<Ticket> items;
  final bool hasNext;
  final bool isLoading;
  final String actionTicketId;
  final bool isActionLoading;
  final Function onFetch;
  final Function onReFetch;
  final Function onSelect;
  final Function onBookmark;

  TicketList({
    Key key,
    @required this.items,
    @required this.hasNext,
    @required this.isLoading,
    @required this.actionTicketId,
    @required this.isActionLoading,
    @required this.onFetch,
    this.onReFetch,
    this.onSelect,
    this.onBookmark,
  }) : super(key: key);

  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> implements TicketAction {
  final _scrollThreshold = 200.0;
  bool _isFetching = false;

  @override
  Widget build(BuildContext context) {
    _isFetching = false;

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        _onScroll(scrollNotification.metrics.maxScrollExtent,
            scrollNotification.metrics.pixels);
        return true;
      },
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return index >= widget.items.length
              ? ListBottomLoader()
              : TicketListItem(
                  item: widget.items[index],
                  actionTicketId: widget.actionTicketId,
                  isActionLoading: widget.isActionLoading,
                  listener: this,
                );
        },
        itemCount:
            widget.hasNext ? widget.items.length + 1 : widget.items.length,
      ),
    );
  }

  void _onScroll(double maxScroll, double currentScroll) {
    if (!_isFetching &&
        !widget.isLoading &&
        widget.hasNext &&
        (maxScroll - currentScroll) <= _scrollThreshold) {
      _isFetching = true;
      widget.onFetch();
    }
  }

  SnackBar _bookmarkSnackBar(Ticket ticket) {
    if (ticket.isBookmark) {
      return _snackBar(
        title: 'Ticket removed from favorites',
        actionTitle: 'Cancel',
        onPressed: () => bookmark(ticket.copyWith(isBookmark: false)),
      );
    }

    return _snackBar(
      title: 'Ticket added to favorites',
    );
  }

  SnackBar _snackBar(
      {@required String title, String actionTitle, void Function() onPressed}) {
    return SnackBar(
      duration: AppSettings.snackBarDisplayDuration,
      content: Text(title),
      action: onPressed != null
          ? SnackBarAction(
              label: actionTitle,
              onPressed: onPressed,
            )
          : null,
    );
  }

  @override
  void select(Ticket ticket) {
    if (widget.onSelect != null) {
      widget.onSelect(ticket);
    }
  }

  @override
  void bookmark(Ticket ticket) {
    if (widget.onBookmark != null) {
      widget.onBookmark(ticket, snackBar: _bookmarkSnackBar(ticket));
    }
  }
}
