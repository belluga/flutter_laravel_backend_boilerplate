import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/bottom_sheet/belluga_bottom_sheet_scaffold.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/button_loading.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/widgets/add_note/color_selector.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/widgets/add_note/controller/add_note_bottom_modal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class AddNoteBottomModal extends StatefulWidget {
  final CourseItemModel courseItemModel;
  final Duration? currentVideoPosition;
  final NoteModel? noteModel;

  const AddNoteBottomModal({
    super.key,
    required this.courseItemModel,
    this.currentVideoPosition,
    this.noteModel,
  });

  @override
  State<AddNoteBottomModal> createState() => _AddNoteBottomModalState();
}

class _AddNoteBottomModalState extends State<AddNoteBottomModal> {
  final _controller = GetIt.I.get<AddNoteBottomModalController>();
  bool _isProcessingAction = false;

  @override
  void initState() {
    super.initState();

    _controller.init(
      courseItemModel: widget.courseItemModel,
      currentVideoPosition: widget.currentVideoPosition,
      noteModel: widget.noteModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BellugaBottomSheetScaffold(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        widget.noteModel == null ? 'Adicionar nota' : 'Editar nota',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamValueBuilder(
            streamValue: _controller.colorSelectedStreamValue,
            builder: (context, colorSelected) {
              return ColorSelector(
                colorOptions: [
                  Colors.yellow.shade200,
                  Colors.pink.shade100,
                  Colors.green.shade100,
                  Colors.blue.shade100,
                ],
                selectedColor: colorSelected,
                onColorSelected: _controller.changeColor,
              );
            },
          ),
          const SizedBox(height: 16),
          StreamValueBuilder(
            streamValue: _controller.colorSelectedStreamValue,
            builder: (context, colorSelected) {
              return Container(
                decoration: BoxDecoration(
                  color: colorSelected,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _controller.noteContentTextController,
                  maxLines: 5,
                  autofocus: widget.noteModel == null,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Digite sua nota...',
                    hintStyle: TextStyle(color: Colors.black54),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottom: Row(
        children: [
          if (widget.noteModel != null) ...[
            Expanded(
              child: ButtonLoading(
                onPressed: _delete,
                loadingStatusStreamValue: _controller.savingNoteStreamValue,
                label: 'Excluir',
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.errorContainer,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: ButtonLoading(
              onPressed: _saveNote,
              loadingStatusStreamValue: _controller.savingNoteStreamValue,
              label: 'Salvar',
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
                foregroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _delete() async {
    if (_isProcessingAction) return;
    _isProcessingAction = true;
    try {
      await _controller.deleteNote();
      _pop();
    } finally {
      _isProcessingAction = false;
    }
  }

  Future<void> _saveNote() async {
    if (_isProcessingAction) return;
    _isProcessingAction = true;
    try {
      await _controller.saveNote();
      _pop();
    } finally {
      _isProcessingAction = false;
    }
  }

  void _pop() {
    if (!mounted) return;
    Navigator.pop(context);
  }
}
