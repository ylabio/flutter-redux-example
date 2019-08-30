import 'package:redux/redux.dart';

import 'ticket_actions.dart';
import 'ticket_state.dart';

Reducer<TicketState> ticketStateReducer = combineReducers<TicketState>([
  TypedReducer<TicketState, TicketLoading>(_loading),
  TypedReducer<TicketState, TicketActionLoading>(_actionLoading),
  TypedReducer<TicketState, TicketListLoaded>(_listLoaded),
  TypedReducer<TicketState, TicketLoaded>(_ticketLoaded),
  TypedReducer<TicketState, TicketBookmark>(_ticketBookmark),
  TypedReducer<TicketState, TicketError>(_error),
  TypedReducer<TicketState, TicketClearError>(_clearError),
]);

// TicketLoading and TicketListLoading
TicketState _loading(TicketState ticketState, TicketLoading action) {
  return ticketState.copyWith(isLoading: true, error: null);
}

TicketState _actionLoading(
    TicketState ticketState, TicketActionLoading action) {
  return ticketState.copyWith(isActionLoading: true, error: null);
}

TicketState _listLoaded(TicketState ticketState, TicketListLoaded action) {
  return ticketState.copyWith(
    ticketList: action.offset == 0
        ? action.ticketList
        : [...ticketState.ticketList, ...action.ticketList],
    hasNext: action.ticketList.length == action.limit,
    isLoading: false,
    error: null,
  );
}

TicketState _ticketLoaded(TicketState ticketState, TicketLoaded action) {
  return ticketState.copyWith(
    ticket: action.ticket,
    isLoading: false,
    error: null,
  );
}

TicketState _ticketBookmark(TicketState ticketState, TicketBookmark action) {
  final ticketList = ticketState.ticketList.map((item) {
    if (action.id == item.id) {
      return item.copyWith(isBookmark: action.isBookmark);
    }
    return item;
  }).toList();

  return ticketState.copyWith(
    ticketList: ticketList,
    ticket: action.id == ticketState.ticket.id
        ? ticketState.ticket.copyWith(isBookmark: action.isBookmark)
        : ticketState.ticket,
    isLoading: false,
    error: null,
  );
}

TicketState _error(TicketState ticketState, TicketError action) {
  return ticketState.copyWith(
    isLoading: false,
    isActionLoading: false,
    error: action.error,
  );
}

TicketState _clearError(TicketState ticketState, TicketClearError action) {
  return ticketState.copyWith(
    isLoading: false,
    isActionLoading: false,
    error: null,
  );
}
