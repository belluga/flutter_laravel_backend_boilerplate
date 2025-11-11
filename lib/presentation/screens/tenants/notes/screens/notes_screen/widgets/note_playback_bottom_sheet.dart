import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NotePlaybackBottomSheet extends StatefulWidget {
  final NoteModel note;
  final CourseItemModel courseItem;

  const NotePlaybackBottomSheet({
    super.key,
    required this.note,
    required this.courseItem,
  });

  @override
  State<NotePlaybackBottomSheet> createState() =>
      _NotePlaybackBottomSheetState();
}

class _NotePlaybackBottomSheetState extends State<NotePlaybackBottomSheet> {
  late final String? _videoUrl =
      widget.courseItem.content?.video?.url.value?.toString();
  VideoPlayerController? _videoController;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final videoUrl = _videoUrl;
    if (videoUrl == null) {
      if (!mounted) return;
      setState(() {
        _error = 'Este conteúdo não possui vídeo associado.';
        _isLoading = false;
      });
      return;
    }
    final controller =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    _videoController = controller;
    try {
      await controller.initialize();
      final position = widget.note.position.value;
      if (position != null) {
        final seekPosition = position > const Duration(seconds: 2)
            ? position - const Duration(seconds: 2)
            : Duration.zero;
        await controller.seekTo(seekPosition);
      }
      controller.play();
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = 'Não foi possível carregar o vídeo.';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.courseItem.title.value,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (_isLoading)
                const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_error != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _error!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              else if (_videoController != null)
                AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                ),
              const SizedBox(height: 16),
              Text(
                'Anotação',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text(
                widget.note.content.value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (widget.note.position.value != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Marcada em ${widget.note.position.valueFormated}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
