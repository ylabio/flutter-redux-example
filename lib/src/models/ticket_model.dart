class Ticket {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final bool isBookmark;

  const Ticket({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.isBookmark = false,
  });

  Ticket.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'] ?? '',
        content = json['content'] ?? '',
        imageUrl = json['image'] != null ? json['image']['url'] ?? '' : '',
        isBookmark = json['isBookmark'] ?? false;

  Ticket copyWith({
    String id,
    String title,
    String content,
    String imageUrl,
    bool isBookmark,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      isBookmark: isBookmark ?? this.isBookmark,
    );
  }

  @override
  String toString() {
    return 'Ticket: {id: $id, title: $title, isBookmark: $isBookmark}';
  }
}
