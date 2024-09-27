import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/models/note_model.dart';

class FirebaseManager {
  late FirebaseFirestore db;

  FirebaseManager() {
    db = FirebaseFirestore.instance;
  }

  Future<List<Note>> getNotes() async {
    List<Note> notes = [];

    await db.collection("notes").get().then((event) {
      for (var doc in event.docs) {
        var data = doc.data();
        var note = Note.fromFirebase(
            id: doc.id,
            title: data['title'],
            content: data['content'],
            updatedAt: new DateTime.fromMillisecondsSinceEpoch(
                data['updatedAt'].millisecondsSinceEpoch));
        notes.add(note);
      }
    });

    return notes;
  }

  Future<String> addNote(Note note) async {
    final data = <String, dynamic>{
      "title": note.title,
      "content": note.content,
      "updatedAt": Timestamp.fromDate(note.updatedAt),
    };

    String id = "-1";

    await db
        .collection("notes")
        .add(data)
        .then((DocumentReference doc) => id = doc.id);

    return id;
  }

  Future<void> updateNote(Note note) async {
    final data = <String, dynamic>{
      "title": note.title,
      "content": note.content,
      "updatedAt": Timestamp.fromDate(note.updatedAt),
    };

    await db
        .collection('notes').doc(note.id).update(data);
  }

  Future<void> deleteNote(Note note) async {
    await db
    .collection("notes").doc(note.id)
    .delete();
  }
}
