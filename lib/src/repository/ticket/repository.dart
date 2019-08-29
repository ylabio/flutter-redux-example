import 'package:meta/meta.dart';

import 'package:flutter_redux_example/src/models/ticket_response.dart';
import 'package:flutter_redux_example/src/models/ticket_list_response.dart';
import 'ticket_api_provider.dart';

class TicketRepository {
  final TicketApiProvider _apiProvider;

  TicketRepository(this._apiProvider);

  TicketApiProvider get apiProvider => _apiProvider;

  Future<TicketListResponse> ticketList({
    @required int offset,
    @required int limit,
    String fields = '_id',
  }) async {
    return await _apiProvider.ticketList(
        offset: offset, limit: limit, fields: fields);
  }

  Future<TicketResponse> ticket({
    @required String id,
    String fields = '_id',
  }) async {
    return await _apiProvider.ticket(id: id, fields: fields);
  }

  Future<TicketResponse> bookmark({
    @required String id,
    String fields = '_id, isBookmark',
  }) async {
    return await _apiProvider.bookmark(id: id, fields: fields);
  }

  Future<TicketResponse> removeBookmark({
    @required String id,
  }) async {
    return await _apiProvider.removeBookmark(id: id);
  }
}
