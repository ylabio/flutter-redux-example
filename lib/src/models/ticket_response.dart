import 'package:flutter_redux_example/src/models/ticket_model.dart';
import 'package:flutter_redux_example/src/utils/app_errors.dart';

class TicketResponse {
  final Ticket ticket;
  final AppBaseError error;

  TicketResponse(this.ticket, this.error);

  TicketResponse.fromJson(Map<String, dynamic> json)
      : ticket = Ticket.fromJson(json),
        error = null;

  TicketResponse.withError(this.error) : ticket = null;
}
