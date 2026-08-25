import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/bottom_modals/gallery_bottom_modal.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/controllers/course_enrollment_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/widgets/course_detail_card.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/widgets/course_enrollment_bottom_bar.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/widgets/course_enrollment_hero.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_enrollment/widgets/course_media_gallery.dart';
import 'package:belluga_boilerplate/domain/learning_experience/file_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CourseEnrollmentScreen extends StatefulWidget {
  const CourseEnrollmentScreen({super.key, required this.course});

  final CourseItemModel course;

  @override
  State<CourseEnrollmentScreen> createState() => _CourseEnrollmentScreenState();
}

class _CourseEnrollmentScreenState extends State<CourseEnrollmentScreen> {
  late final CourseEnrollmentController _controller;
  late final ScrollController _scrollController;
  late final ValueNotifier<bool> _bottomBarVisibleNotifier;
  late final List<Uri?> _galleryItems;

  final _mainButtonKey = GlobalKey();
  double _visibilityThreshold = double.infinity;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I.get<CourseEnrollmentController>();
    _scrollController = ScrollController()..addListener(_handleScroll);
    _bottomBarVisibleNotifier = ValueNotifier<bool>(false);
    _galleryItems = _prepareGalleryItems(widget.course.files);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateThreshold());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: CourseEnrollmentHero(
                  course: widget.course,
                  onEnroll: () => _handleEnroll(widget.course),
                  isEnrollingStream: _controller.isEnrollingStreamValue,
                  mainButtonKey: _mainButtonKey,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      CourseDetailCard(
                        title: 'Sobre o Curso',
                        icon: Icons.menu_book_rounded,
                        body: Text(
                          widget.course.description.value,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (widget.course.teachers.isNotEmpty)
                        CourseDetailCard(
                          title: 'Instrutores',
                          icon: Icons.people_alt_rounded,
                          body: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.course.teachers
                                .map(
                                  (teacher) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      teacher.name.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      if (widget.course.teachers.isNotEmpty)
                        const SizedBox(height: 16),
                      if (widget.course.childrensSummary != null)
                        CourseDetailCard(
                          title: 'Estrutura',
                          icon: Icons.auto_stories_rounded,
                          body: Text(
                            '${widget.course.childrensSummary!.total.value} ${widget.course.childrensSummary!.label.value}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (_galleryItems.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: CourseMediaGallery(
                    mediaItems: _galleryItems,
                    onViewAll: () => _openGalleryBottomModal(_galleryItems),
                  ),
                ),
              const SliverSafeArea(
                sliver: SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                ),
              ),
            ],
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _bottomBarVisibleNotifier,
            builder: (context, isVisible, _) {
              return CourseEnrollmentBottomBar(
                isVisible: isVisible,
                isEnrollingStream: _controller.isEnrollingStreamValue,
                onEnroll: () => _handleEnroll(widget.course),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleEnroll(CourseItemModel course) async {
    final enrolled = await _controller.enroll(course.id.value);
    if (!mounted || !enrolled) return;
    context.router.replace(CourseRoute(courseItemId: course.id.value));
  }

  void _handleScroll() {
    if (_visibilityThreshold == double.infinity) return;
    final shouldShowBottom = _scrollController.offset >= _visibilityThreshold;
    if (_bottomBarVisibleNotifier.value != shouldShowBottom) {
      _bottomBarVisibleNotifier.value = shouldShowBottom;
    }
  }

  void _calculateThreshold() {
    final renderBox =
        _mainButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final widgetBottomEdge = position.dy + renderBox.size.height;
    _visibilityThreshold = widgetBottomEdge - kToolbarHeight;
    _handleScroll();
  }

  List<Uri?> _prepareGalleryItems(List<FileModel> files) {
    if (files.isNotEmpty) {
      return files
          .map((file) => file.thumb.thumbUri.value)
          .whereType<Uri?>()
          .toList();
    }
    return List.generate(6, (_) => widget.course.thumb.thumbUri.value);
  }

  void _openGalleryBottomModal(List<Uri?> mediaItems) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => GalleryBottomModal(mediaItems: mediaItems),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _bottomBarVisibleNotifier.dispose();
    super.dispose();
  }
}
