class Note {
  String id = "-1";
  String title;
  String content;
  DateTime updatedAt = DateTime.now();

  Note({ required this.title, required this.content, this.id = "-1"});
  Note.fromFirebase({ required this.title, required this.content, required this.updatedAt, required this.id});

  void update({ required title, required content }) {
    this.title = title;
    this.content = content;
    this.updatedAt = DateTime.now();
  }
}
