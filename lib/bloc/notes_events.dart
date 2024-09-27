import 'package:todo_list/models/note_model.dart';

/**
 * Определите абстрактный класс событий NoteEvent
 * и дочерние классы событий: LoadEvent, AddEvent, UpdateEvent и DeleteEvent.
 */

abstract class NoteEvent {}

class LoadEvent extends NoteEvent {
  final int index;

  LoadEvent({ required this.index});
}

class AddEvent extends NoteEvent {
  final Note note;

  AddEvent({ required this.note});
}

class ChangeTitleEvent extends NoteEvent {
  final String title;

  ChangeTitleEvent({ required this.title});
}

class ChangeContentEvent extends NoteEvent {
  final String content;

  ChangeContentEvent({ required this.content});
}

class UpdateEvent extends NoteEvent {
  final Note note;
  final int index;

  UpdateEvent({ required this.note, required this.index});
}

class DeleteEvent extends NoteEvent {
  final int index;

  DeleteEvent({ required this.index});
}
