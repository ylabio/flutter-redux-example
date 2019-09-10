import 'package:flutter_redux_example/src/models/ticket_model.dart';
import 'package:flutter_redux_example/src/utils/app_errors.dart';

class TicketListResponse {
  final List<Ticket> tickets;
  final int totalCount;
  final AppBaseError error;

  TicketListResponse(this.tickets, this.totalCount, this.error);

  TicketListResponse.fromJson(Map<String, dynamic> json)
      : tickets = List<Map<String, dynamic>>.from(json['items'])
            .map((Map<String, dynamic> item) => Ticket.fromJson(item))
            .toList(),
        totalCount = json['count'],
        error = null;

  TicketListResponse.withError(this.error)
      : tickets = null,
        totalCount = null;
}
