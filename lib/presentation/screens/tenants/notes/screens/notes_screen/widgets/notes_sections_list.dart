import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:belluga_boilerplate/domain/notes/projections/notes_section_projection.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/widgets/note_card.dart';
import 'package:flutter/material.dart';

class NotesSectionsList extends StatelessWidget {
  final List<NotesSectionProjection> sections;
  final ValueChanged<NoteModel> onNoteTap;
  final Color dividerColor;

  const NotesSectionsList({
    super.key,
    required this.sections,
    required this.onNoteTap,
    required this.dividerColor,
  });

  @override
  Widget build(BuildContext context) {
    final groupedSections = _groupSectionsByCourse(sections);
    return ListView.builder(
      itemCount: groupedSections.length,
      itemBuilder: (context, courseIndex) {
        final courseGroup = groupedSections[courseIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseGroup.courseTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...List.generate(courseGroup.sections.length, (sectionIndex) {
              final section = courseGroup.sections[sectionIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
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
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      for (var i = 0; i < section.notes.length; i++)
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  i == section.notes.length - 1 ? 0 : 12),
                          child: NoteCard(
                            noteModel: section.notes[i],
                            index: i,
                            onCardTap: ({noteModel}) {
                              if (noteModel != null) {
                                onNoteTap(noteModel);
                              }
                            },
                            onTimeTap: () => onNoteTap(section.notes[i]),
                          ),
                        ),
                    ],
                  ),
                  if (sectionIndex != courseGroup.sections.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Divider(
                        color: dividerColor,
                      ),
                    ),
                ],
              );
            }),
            if (courseIndex != groupedSections.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Divider(
                  color: dividerColor,
                  thickness: 2,
                ),
              ),
          ],
        );
      },
    );
  }

  List<_CourseSectionGroup> _groupSectionsByCourse(
    List<NotesSectionProjection> sections,
  ) {
    final Map<String, _CourseSectionGroup> grouped = {};
    final order = <String>[];
    for (final section in sections) {
      if (!grouped.containsKey(section.courseTitle)) {
        grouped[section.courseTitle] =
            _CourseSectionGroup(courseTitle: section.courseTitle);
        order.add(section.courseTitle);
      }
      grouped[section.courseTitle]!.sections.add(section);
    }
    return order.map((title) => grouped[title]!).toList();
  }
}

class _CourseSectionGroup {
  final String courseTitle;
  final List<NotesSectionProjection> sections;

  _CourseSectionGroup({
    required this.courseTitle,
  }) : sections = [];
}
