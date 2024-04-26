class Book {
  late int id;
  late String title, author, description;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
  });

  Book.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        description = json['description'];

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
    };
  }
}
