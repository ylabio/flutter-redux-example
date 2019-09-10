class User {
  final String id;
  final String name;

  const User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'] ?? '';

  @override
  String toString() {
    return 'User: {id: $id, name: $name}';
  }
}
