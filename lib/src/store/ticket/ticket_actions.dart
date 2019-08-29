import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:flutter_redux_example/src/models/ticket_model.dart';
import 'package:flutter_redux_example/src/repository/ticket/repository.dart';
import 'package:flutter_redux_example/src/store/app/app_state.dart';
import 'package:flutter_redux_example/src/utils/app_errors.dart';

abstract class TicketAction {
  @override
  String toString() {
    return '$runtimeType';
  }
}

class TicketLoading extends TicketAction {}

class TicketActionLoading extends TicketAction {}

class TicketListLoaded extends TicketAction {
  final List<Ticket> ticketList;
  final int totalCount;
  final int offset;
  final int limit;

  TicketListLoaded({this.ticketList, this.totalCount, this.offset, this.limit});
}

class TicketLoaded extends TicketAction {
  final Ticket ticket;

  TicketLoaded({this.ticket});
}

class TicketBookmark extends TicketAction {
  final Ticket ticket;

  TicketBookmark({this.ticket});
}

class TicketRemoveBookmark extends TicketAction {
  final String id;

  TicketRemoveBookmark({this.id});
}

class TicketError extends TicketAction {
  final AppBaseError error;

  TicketError({this.error});
}

class TicketClearError extends TicketAction {}

ThunkAction<AppState> fetchTicketList(context, {int limit = 10}) {
  final ticketRepository = Provider.of<TicketRepository>(context);
  return (Store<AppState> store) async {
    store.dispatch(TicketLoading());

    final offset = store.state.ticketState?.ticketList?.length ?? 0;
    final ticketListResponse =
        await ticketRepository.ticketList(offset: offset, limit: limit);

    store.dispatch(TicketListLoaded(
      ticketList: ticketListResponse.tickets,
      totalCount: ticketListResponse.totalCount,
      offset: offset,
      limit: limit,
    ));
  };
}

ThunkAction<AppState> refetchTicketList(context, {int limit = 10}) {
  final ticketRepository = Provider.of<TicketRepository>(context);
  return (Store<AppState> store) async {
    store.dispatch(TicketLoading());

    final ticketListResponse =
        await ticketRepository.ticketList(offset: 0, limit: limit);

    store.dispatch(TicketListLoaded(
      ticketList: ticketListResponse.tickets,
      totalCount: ticketListResponse.totalCount,
      offset: 0,
      limit: limit,
    ));
  };
}
