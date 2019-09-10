class UrlProvider {
  static const String base = 'http://localhost:8160/api/v1';

  static String get sign {
    return '$base/users/sign';
  }

  static String get profile {
    return '$base/users/self';
  }

  static String get ticketList {
    return '$base/tickets';
  }

  static String ticket(String id) {
    return '$base/tickets/$id';
  }

  static String ticketBookmark(String id) {
    return '$base/tickets/$id/bookmark';
  }
}
