import 'package:belluga_boilerplate/infrastructure/services/notes_backend_contract.dart';
import 'package:flutter/rendering.dart';
import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/notes/note_dto.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

abstract class NotesRepositoryContract {
  NotesBackendContract get notesBackend => GetIt.I.get();

  final notesSteamValue = StreamValue<List<NoteModel>?>(defaultValue: null);

  Future<void> getNotes(String courseItemId) async {
    notesSteamValue.addValue(null);
    final notes = await loadNotesForCourse(courseItemId);
    notesSteamValue.addValue(notes);
  }

  Future<List<NoteModel>> loadNotesForCourse(String courseItemId) async {
    final List<NoteDTO> notesRaw = await notesBackend.getNotes(courseItemId);
    final notes = notesRaw.map(NoteModel.fromDTO).toList();
    notes.sort(_compareNotes);
    return notes;
  }

  Future<Map<String, List<NoteModel>>> loadNotesByCourse() async {
    final grouped = await notesBackend.getNotesByCourse();
    final result = <String, List<NoteModel>>{};
    grouped.forEach((courseId, noteList) {
      final models = noteList.map(NoteModel.fromDTO).toList();
      models.sort(_compareNotes);
      result[courseId] = models;
    });
    return result;
  }

  Future<void> createNote({
    required String courseItemId,
    required String content,
    required Color color,
    Duration? position,
  }) async {
    await notesBackend.createNote(
      color: color,
      courseItemId: courseItemId,
      content: content,
      position: position,
    );
    await getNotes(courseItemId);
  }

  Future<void> updateNote({
    required String id,
    required String courseItemId,
    required String content,
    required Color color,
    Duration? position,
  }) async {
    await notesBackend.updateNote(
      id: id,
      color: color,
      courseItemId: courseItemId,
      content: content,
      position: position,
    );
    await getNotes(courseItemId);
  }

  Future<NoteModel?> getNote(
      {required String courseId, required String noteId}) async {
    final NoteDTO? _noteRaw =
        await notesBackend.getNote(courseId: courseId, noteId: noteId);
    if (_noteRaw == null) {
      return null;
    }
    return NoteModel.fromDTO(_noteRaw);
  }

  Future<void> deleteNote(
      {required String courseId, required String noteId}) async {
    final NoteModel? _note = await getNote(
      courseId: courseId,
      noteId: noteId,
    );
    if (_note != null) {
      await notesBackend.deleteNote(noteId);
      await getNotes(_note.courseItemId.value);
    }
  }

  int _compareNotes(NoteModel a, NoteModel b) {
    final Duration? positionA = a.position.value;
    final Duration? positionB = b.position.value;

    if (positionA == null && positionB == null) {
      return 0;
    }

    if (positionA == null) {
      return 1;
    }

    if (positionB == null) {
      return -1;
    }

    return positionA.compareTo(positionB);
  }
}
