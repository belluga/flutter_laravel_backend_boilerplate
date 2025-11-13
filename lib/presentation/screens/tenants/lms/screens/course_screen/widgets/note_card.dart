import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/domain/notes/note_model.dart';

class NoteCard extends StatefulWidget {
  final NoteModel noteModel;
  final void Function({NoteModel? noteModel}) onCardTap;
  final int index;
  final VoidCallback? onTimeTap;

  const NoteCard({
    super.key,
    required this.noteModel,
    required this.onCardTap,
    required this.index,
    this.onTimeTap,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => widget.onCardTap(noteModel: widget.noteModel),
        child: IntrinsicHeight(
          child: Container(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: widget.noteModel.color.value,
                        width: 32,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.noteModel.content.value,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        if (widget.noteModel.position.value != null)
                          InkWell(
                            onTap: widget.onTimeTap,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: .0,
                              ),
                              child: Text(
                                widget.noteModel.position.valueFormated,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
