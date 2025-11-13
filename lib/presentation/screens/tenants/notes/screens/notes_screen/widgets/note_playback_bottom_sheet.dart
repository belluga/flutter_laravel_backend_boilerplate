import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/bottom_sheet/belluga_bottom_sheet_scaffold.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/notes/controllers/note_playback_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:video_player/video_player.dart';

class NotePlaybackBottomSheet extends StatefulWidget {
  final NoteModel note;
  final CourseItemModel courseItem;
  final VoidCallback? onNavigateToCourse;

  const NotePlaybackBottomSheet({
    super.key,
    required this.note,
    required this.courseItem,
    this.onNavigateToCourse,
  });

  @override
  State<NotePlaybackBottomSheet> createState() =>
      _NotePlaybackBottomSheetState();
}

class _NotePlaybackBottomSheetState extends State<NotePlaybackBottomSheet> {
  final _controller = GetIt.I.get<NotePlaybackController>();
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      await _controller.initPlayer(
        courseItem: widget.courseItem,
        note: widget.note,
      );
      if (!mounted) return;
      setState(() => _isLoading = false);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BellugaBottomSheetScaffold(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.courseItem.title.value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (widget.courseItem.parent != null)
            Text(
              widget.courseItem.parent!.title.value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
      actions: [
        if (widget.onNavigateToCourse != null)
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: widget.onNavigateToCourse,
          ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _buildVideoArea(),
          ),
          const SizedBox(height: 16),
          _NoteCardLayout(note: widget.note),
        ],
      ),
    );
  }

  Widget _buildVideoArea() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: const TextStyle(color: Colors.redAccent),
        ),
      );
    }
    if (!_controller.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    final video = _controller.videoController;
    return GestureDetector(
      onTap: () {
        if (video.value.isPlaying) {
          video.pause();
        } else {
          video.play();
        }
        setState(() {});
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: video.value.aspectRatio,
            child: VideoPlayer(video),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              video.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
              size: 56,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteCardLayout extends StatelessWidget {
  final NoteModel note;

  const _NoteCardLayout({required this.note});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 80,
            decoration: BoxDecoration(
              color: note.color.value,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.content.value,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (note.position.value != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      note.position.valueFormated,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
