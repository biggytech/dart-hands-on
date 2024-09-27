import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/notes_events.dart';
import 'package:todo_list/bloc/notes_state.dart';
import 'package:todo_list/managers/FirebaseManager.dart';
import 'package:todo_list/models/note_model.dart';

/**
 *   Создайте файлы для BLoC:
 * это включает файл для самого BLoC,
 * файл для состояния (State)
 * и файл для событий (Events).
 */
class NotesBloc extends Bloc<NoteEvent, NoteState> {
  NotesBloc() : super(NoteState(notes: [])) {
    on<InitializeEvent>((event, emit) {
      return emit(NoteState(notes: event.notes));
    });
    on<LoadEvent>((event, emit) {
      var note = state.notes[event.index];

      state.updateTitle(note.title);
      state.updateContent(note.content);
      state.updateId(note.id);
      return emit(state);
    });
    on<AddEvent>((event, emit) async {
      List<Note> newNotes = List.from(state.notes);

      var firebaseNoteId = await FirebaseManager().addNote(event.note);
      event.note.id = firebaseNoteId;

      newNotes.add(event.note);
      return emit(AddState(notes: newNotes));
    });
    on<ChangeTitleEvent>((event, emit) {
      state.updateTitle(event.title);
      return emit(state);
    });
    on<ChangeContentEvent>((event, emit) {
      state.updateContent(event.content);
      return emit(state);
    });
    on<UpdateEvent>((event, emit) async {
      List<Note> newNotes = List.from(state.notes);

      await FirebaseManager().updateNote(event.note);

      newNotes[event.index] = event.note;
      return emit(UpdateState(notes: newNotes));
    });
    on<DeleteEvent>((event, emit) async {
      List<Note> newNotes = List.from(state.notes);
      var note = newNotes[event.index];

      await FirebaseManager().deleteNote(note);

      newNotes.removeAt(event.index);
      return emit(DeleteState(notes: newNotes));
    });
  }
}
