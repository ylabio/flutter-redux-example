import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux_example/src/ui/widgets/page_loader.dart';
import 'package:flutter_redux_example/src/ui/widgets/ticket_list.dart';
import 'package:flutter_redux_example/src/models/ticket_model.dart';
import 'package:flutter_redux_example/src/store/app/app_state.dart';
import 'package:flutter_redux_example/src/store/auth/store.dart';
import 'package:flutter_redux_example/src/store/ticket/store.dart';
import 'package:flutter_redux_example/src/utils/app_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: StoreConnector<AppState, HomeScreenTicketViewModel>(
        onInit: (store) {
          store.dispatch(refetchTicketList(context));
        },
        converter: (store) => HomeScreenTicketViewModel.fromStore(store),
        builder: (context, viewModel) {
          if (viewModel.ticketState.isLoading) {
            return PageLoader();
          }

          if (viewModel.ticketState.ticketList.isNotEmpty) {
            return _ticketList(context, viewModel);
          }

          return _emptyList();
        },
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text('Home'),
      actions: <Widget>[
        StoreConnector<AppState, HomeScreenAuthViewModel>(
          converter: (store) => HomeScreenAuthViewModel.fromStore(store),
          builder: (context, viewModel) {
            return IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                viewModel.logout(context);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _ticketList(context, viewModel) {
    return TicketList(
      items: viewModel.ticketState.ticketList,
      hasNext: viewModel.ticketState.hasNext,
      isLoading: viewModel.ticketState.isLoading,
      onFetch: () => viewModel.fetchList(context),
      onReFetch: () => viewModel.refetchList(context),
      onSelect: (Ticket ticket) {
        Navigator.of(context).pushNamed(
          AppRouter.detailRoute,
          arguments: ticket,
        );
      },
      onBookmark: (Ticket ticket) {
        viewModel.bookmark(context, ticket.id, !ticket.isBookmark);
      },
    );
  }

  Widget _emptyList() {
    return Center(
      child: Icon(
        Icons.format_list_bulleted,
        color: Colors.black45,
        size: 125,
      ),
    );
  }
}

class HomeScreenAuthViewModel {
  final Function logout;

  HomeScreenAuthViewModel({
    this.logout,
  });

  static HomeScreenAuthViewModel fromStore(Store<AppState> store) {
    return HomeScreenAuthViewModel(
      logout: (context) => store.dispatch(signout(context)),
    );
  }
}

class HomeScreenTicketViewModel {
  final TicketState ticketState;
  final Function fetchList;
  final Function refetchList;
  final Function bookmark;

  HomeScreenTicketViewModel({
    this.ticketState,
    this.fetchList,
    this.refetchList,
    this.bookmark,
  });

  static HomeScreenTicketViewModel fromStore(Store<AppState> store) {
    return HomeScreenTicketViewModel(
      ticketState: store.state.ticketState,
      fetchList: (context) => store.dispatch(fetchTicketList(context)),
      refetchList: (context) => store.dispatch(refetchTicketList(context)),
      bookmark: (context, id, isBookmark) => store
          .dispatch(bookmarkTicket(context, id: id, isBookmark: isBookmark)),
    );
  }
}
