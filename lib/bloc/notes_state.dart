import 'package:todo_list/models/note_model.dart';

/**
 * В файле состояния (State) определите абстрактный класс состояний NoteState
 * и дочерние классы состояния,
 * такие как LoadState, AddState, UpdateState и DeleteState,
 * которые будут представлять состояния при выполнении соответствующих событий.
 */

class NoteState {
  String title = "";
  String content = "";

  List<Note> notes;

  NoteState({required this.notes});

  void updateTitle(String title) {
    this.title = title;
  }

  void updateContent(String content) {
    this.content = content;
  }
}

class LoadState extends NoteState {
  LoadState({required List<Note> notes}) : super(notes: notes);
}

class AddState extends NoteState {
  AddState({required List<Note> notes}) : super(notes: notes);
}

class UpdateState extends NoteState {
  UpdateState({required List<Note> notes}) : super(notes: notes);
}

class DeleteState extends NoteState {
  DeleteState({required List<Note> notes}) : super(notes: notes);
}
