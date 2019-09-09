import 'package:meta/meta.dart';

import 'package:flutter_redux_example/src/models/ticket_model.dart';
import 'package:flutter_redux_example/src/utils/app_errors.dart';

@immutable
class TicketState {
  final List<Ticket> ticketList;
  final Ticket ticket;
  final int totalCount;
  final bool hasNext;
  final bool isLoading;
  final String actionTicketId;
  final bool isActionLoading;
  final AppBaseError error;

  const TicketState(
      {this.ticketList,
      this.ticket,
      this.totalCount,
      this.hasNext,
      this.isLoading,
      this.actionTicketId,
      this.isActionLoading,
      this.error});

  factory TicketState.initial() {
    return TicketState(
      ticketList: [],
      ticket: null,
      totalCount: 0,
      hasNext: false,
      isLoading: false,
      actionTicketId: '',
      isActionLoading: false,
      error: null,
    );
  }

  TicketState copyWith({
    List<Ticket> ticketList,
    Ticket ticket,
    int totalCount,
    bool hasNext,
    bool isLoading,
    String actionTicketId,
    bool isActionLoading,
    AppBaseError error,
  }) {
    return TicketState(
      ticketList: ticketList ?? this.ticketList,
      ticket: ticket ?? this.ticket,
      totalCount: totalCount ?? this.totalCount,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
      actionTicketId: actionTicketId ?? this.actionTicketId,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      error: error,
    );
  }

  @override
  int get hashCode =>
      ticketList.hashCode ^
      ticket.hashCode ^
      totalCount.hashCode ^
      hasNext.hashCode ^
      isLoading.hashCode ^
      actionTicketId.hashCode ^
      isActionLoading.hashCode ^
      error.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketState &&
          runtimeType == other.runtimeType &&
          ticketList == other.ticketList &&
          ticket == other.ticket &&
          totalCount == other.totalCount &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading &&
          actionTicketId == other.actionTicketId &&
          isActionLoading == other.isActionLoading &&
          error == other.error;

  @override
  String toString() {
    return 'TicketState{ticketList: $ticketList, ticket: $ticket, totalCount: $totalCount, hasNext: $hasNext, isLoading: $isLoading, actionTicketId: $actionTicketId, isActionLoading: $isActionLoading, error: $error}';
  }
}
