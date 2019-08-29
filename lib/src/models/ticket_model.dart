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

  @override
  String toString() {
    return 'Ticket: {id: $id, title: $title, isBookmark: $isBookmark}';
  }
}
