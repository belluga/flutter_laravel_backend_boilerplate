import 'package:belluga_boilerplate/domain/notes/note_model.dart';

class NotesSectionProjection {
  final String nodeId;
  final String title;
  final String? subtitle;
  final List<int> orderKey;
  final List<NoteModel> notes;

  const NotesSectionProjection({
    required this.nodeId,
    required this.title,
    required this.notes,
    required this.orderKey,
    this.subtitle,
  });
}
