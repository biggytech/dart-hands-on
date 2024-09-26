class Note {
  String title;
  String content;
  DateTime updatedAt = DateTime.now();

  Note({ required this.title, required this.content});

  void update({ required title, required content }) {
    this.title = title;
    this.content = content;
    this.updatedAt = DateTime.now();
  }
}
