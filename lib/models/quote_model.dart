/**
 * Создайте модель 'Quote' с помощью Null Safety,
 * которая будет представлять цитату и будет содержать поля, такие как ‘content’, ‘author' и другие.
 */
class Quote {
  final String content;
  final String author;
  final List<String> tags;

  Quote({required this.content, required this.author, required this.tags});

  /**
   * Распарсите полученные данные JSON из API в объект,
   * используя конструктор модели.
   */
  factory Quote.fromJson(Map<String, dynamic> json) {
    final String content = json['content'];
    final String author = json['author'];
    final List<String> tags = (json['tags'] as List)?.map((item) => item as String)?.toList() ?? [];

    return Quote(content: content,
          author: author,
          tags: tags);
  }
}
