import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_redux_example/src/ui/widgets/list_bottom_loader.dart';
import 'package:flutter_redux_example/src/ui/widgets/ticket_list_item.dart';
import 'package:flutter_redux_example/src/models/ticket_model.dart';

class TicketList extends StatelessWidget implements TicketAction {
  final List<Ticket> items;
  final bool hasNext;
  final bool isLoading;
  final bool isActionLoading;
  final Function onFetch;
  final Function onReFetch;
  final Function onSelect;
  final Function onBookmark;

  final _scrollThreshold = 200.0;

  TicketList({
    Key key,
    @required this.items,
    @required this.hasNext,
    @required this.isLoading,
    @required this.isActionLoading,
    this.onFetch,
    this.onReFetch,
    this.onSelect,
    this.onBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          return index >= items.length
              ? ListBottomLoader()
              : TicketListItem(
                  item: items[index],
                  isActionLoading: isActionLoading,
                  listener: this,
                );
        },
        itemCount: hasNext ? items.length + 1 : items.length,
      ),
    );
  }

  void _onScroll(double maxScroll, double currentScroll) {
    if (!isLoading &&
        hasNext &&
        (maxScroll - currentScroll) <= _scrollThreshold) {
      onFetch();
    }
  }

  @override
  void select(Ticket ticket) {
    if (onSelect != null) {
      onSelect(ticket);
    }
  }

  @override
  void bookmark(Ticket ticket) {
    if (onBookmark != null) {
      onBookmark(ticket);
    }
  }
}
