import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux_example/src/ui/widgets/page_loader.dart';
import 'package:flutter_redux_example/src/models/ticket_model.dart';
import 'package:flutter_redux_example/src/store/app/app_state.dart';
import 'package:flutter_redux_example/src/store/ticket/store.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Ticket ticket = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _appBar(context),
      body: StoreConnector<AppState, DetailScreenTicketViewModel>(
        onInit: (store) {
          store.dispatch(fetchTicket(context, id: ticket.id));
        },
        converter: (store) =>
            DetailScreenTicketViewModel.fromStore(context, store),
        builder: (context, viewModel) {
          if (viewModel.ticketState.isLoading) {
            return PageLoader();
          }

          if (viewModel.ticketState.ticket != null) {
            return _ticket(viewModel);
          }

          return _emptyPage();
        },
      ),
    );
  }

  PreferredSizeWidget _appBar(context) {
    return AppBar(
      title: Text('Ticket'),
      actions: <Widget>[
        StoreConnector<AppState, DetailScreenTicketViewModel>(
          converter: (store) =>
              DetailScreenTicketViewModel.fromStore(context, store),
          builder: (context, viewModel) {
            final ticket = viewModel.ticketState.ticket;
            return IconButton(
              icon: Icon(
                ticket?.isBookmark ?? false
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: viewModel.ticketState.isActionLoading
                  ? null
                  : () {
                      viewModel.bookmark(ticket.id, !ticket.isBookmark);
                    },
            );
          },
        ),
      ],
    );
  }

  Widget _ticket(DetailScreenTicketViewModel viewModel) {
    final ticket = viewModel.ticketState.ticket;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(ticket?.imageUrl ?? ''),
            Text(ticket?.title ?? ''),
            Text(ticket?.content ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _emptyPage() {
    return Center(
      child: Icon(
        Icons.restore_page,
        color: Colors.black45,
        size: 125,
      ),
    );
  }
}

class DetailScreenTicketViewModel {
  final TicketState ticketState;
  final Function bookmark;

  DetailScreenTicketViewModel({
    this.ticketState,
    this.bookmark,
  });

  static DetailScreenTicketViewModel fromStore(context, Store<AppState> store) {
    return DetailScreenTicketViewModel(
      ticketState: store.state.ticketState,
      bookmark: (id, isBookmark) => store
          .dispatch(bookmarkTicket(context, id: id, isBookmark: isBookmark)),
    );
  }
}
