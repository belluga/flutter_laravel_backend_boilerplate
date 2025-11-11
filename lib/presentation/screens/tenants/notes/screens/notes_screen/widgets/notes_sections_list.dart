import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:belluga_boilerplate/domain/notes/projections/notes_section_projection.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/widgets/note_card.dart';
import 'package:flutter/material.dart';

class NotesSectionsList extends StatelessWidget {
  final List<NotesSectionProjection> sections;
  final ValueChanged<NoteModel> onTimestampTap;
  final ValueChanged<NoteModel> onNoteTap;
  final Color dividerColor;

  const NotesSectionsList({
    super.key,
    required this.sections,
    required this.onTimestampTap,
    required this.onNoteTap,
    required this.dividerColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, sectionIndex) {
        final section = sections[sectionIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (section.subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                section.subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
            const SizedBox(height: 12),
            Column(
              children: [
                for (var i = 0; i < section.notes.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: i == section.notes.length - 1 ? 0 : 12),
                    child: NoteCard(
                      noteModel: section.notes[i],
                      index: i,
                      onCardTap: ({noteModel}) {
                        if (noteModel != null) {
                          onNoteTap(noteModel);
                        }
                      },
                      onTimestampTap: (note) => onTimestampTap(note),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Divider(color: dividerColor),
      ),
      itemCount: sections.length,
    );
  }
}
