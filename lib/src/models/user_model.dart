class User {
  final String id;
  final String name;

  const User(this.id, this.name);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
