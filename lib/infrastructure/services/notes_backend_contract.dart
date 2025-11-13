import 'package:flutter/rendering.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/notes/note_dto.dart';

abstract class NotesBackendContract {
  Future<List<NoteDTO>> getNotes(String courseItemId);
  Future<Map<String, List<NoteDTO>>> getNotesByCourse();
  Future<void> createNote({
    required String courseItemId,
    required String content,
    Duration? position,
    required Color color,
  });
  Future<void> updateNote({
    required String id,
    required String courseItemId,
    required String content,
    Duration? position,
    required Color color,
  });
  Future<void> deleteNote(String noteId);
  Future<NoteDTO?> getNote({required String courseId, required String noteId});
}
