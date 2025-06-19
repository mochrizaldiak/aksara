class Book {
  final String title;
  final String author;
  final String imagePath;
  final String description;
  final String language;
  final String releaseDate;
  final String publisher;
  final int stock;
  final String origin;

  Book({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.description,
    required this.language,
    required this.releaseDate,
    required this.publisher,
    required this.stock,
    required this.origin,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      imagePath: json['imagePath'],
      description: json['description'],
      language: json['language'],
      releaseDate: json['releaseDate'],
      publisher: json['publisher'],
      stock: json['stock'],
      origin: json['origin'],
    );
  }
}
