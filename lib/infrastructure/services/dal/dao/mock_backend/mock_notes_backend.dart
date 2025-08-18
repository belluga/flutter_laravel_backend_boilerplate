import 'package:belluga_boilerplate/application/extensions/color_to_hex.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/notes/note_dto.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dao/mock_backend/mock_functions.dart';
import 'package:belluga_boilerplate/infrastructure/services/notes_backend_contract.dart';
import 'package:flutter/rendering.dart';

class MockNotesBackend extends NotesBackendContract with MockFunctions {
  @override
  Future<List<NoteDTO>> getNotes(String courseItemId) {
    return Future.delayed(Duration(seconds: 1), () {
      if (!_notes.containsKey(courseItemId)) {
        return [];
      }
      return _notes[courseItemId]!;
    });
  }

  @override
  Future<void> createNote({
    required String courseItemId,
    required String content,
    Duration? position,
    required Color color,
  }) {
    return Future.delayed(Duration(seconds: 1), () {
      final NoteDTO _note = NoteDTO(
        id: fakeMongoId,
        courseItemId: courseItemId,
        content: content,
        colorHex: color.toHex(),
        position: position?.toString(),
      );
      _notes.putIfAbsent(courseItemId, () => []).add(_note);
    });
  }

  @override
  Future<void> updateNote({
    required String id,
    required String courseItemId,
    required String content,
    Duration? position,
    required Color color,
  }) {
    return Future.delayed(Duration(seconds: 1), () {
      if (!_notes.containsKey(courseItemId)) {
        throw Exception("Note not found for course item: $courseItemId");
      }
      final notesList = _notes[courseItemId]!;
      final index = notesList.indexWhere((n) => n.id == id);
      if (index == -1) {
        throw Exception("Note not found with id: $id");
      }
      notesList[index].colorHex = color.toHex();
      notesList[index].content = content;
      notesList[index].position = position?.toString();
    });
  }

  @override
  Future<void> deleteNote(String id) {
    return Future.delayed(Duration(seconds: 1), () {
      _notes.forEach((courseItemId, notesList) {
        final index = notesList.indexWhere((n) => n.id == id);
        if (index != -1) {
          notesList.removeAt(index);
        }
      });
    });
  }

  @override
  Future<NoteDTO?> getNote({
    required String courseId,
    required String noteId,
  }) async {
    return Future.delayed(Duration(seconds: 1), () {
      final List<NoteDTO>? notesList = _notes[courseId];
      if (notesList == null) {
        return null;
      }
      return notesList.firstWhere((n) => n.id == noteId);
    });
  }

  final Map<String, List<NoteDTO>> _notes = {};
}
