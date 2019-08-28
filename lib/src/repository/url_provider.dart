class UrlProvider {
  static const String base = 'https://example.com/api/v1';

  static String get sign {
    return '$base/users/sign';
  }

  static String get profile {
    return '$base/users/self';
  }

  static String get items {
    return '$base/items';
  }

  static String item(String id) {
    return '$base/items/$id';
  }

  static String bookmarkItem(String id) {
    return '$base/items/$id/bookmark';
  }
}
