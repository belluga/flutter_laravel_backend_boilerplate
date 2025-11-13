import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/bottom_modals/gallery_bottom_modal.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/controller/event_item_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/widgets/animated_bottom_area.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/widgets/event_info_card.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/widgets/header.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/widgets/sliver_photo_gallery.dart';

class EventItemScreen extends StatefulWidget {
  final EventModel event;

  const EventItemScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventItemScreen> createState() => _EventItemScreenState();
}

class _EventItemScreenState extends State<EventItemScreen> {
  late EventItemController _controller;

  @override
  void initState() {
    super.initState();
    _registerController();
    _controller.init(widget.event);
  }

  void _registerController() {
    if (GetIt.I.isRegistered<EventItemController>()) {
      GetIt.I.unregister<EventItemController>();
    }
    _controller = GetIt.I.registerSingleton(EventItemController());
  }

  @override
  Widget build(BuildContext context) {
    return StreamValueBuilder<EventModel?>(
      streamValue: _controller.eventStreamValue,
      onNullWidget: const Center(child: CircularProgressIndicator()),
      builder: (context, event) {
        if (event == null) {
          return const SizedBox.shrink();
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _calculateThreshold();
        });

        final galleryItems = List.generate(
          9,
          (_) => event.thumb?.thumbUri.value,
        );

        return Scaffold(
          backgroundColor: _controller.colorScheme.primary,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
                controller: _controller.scrollController,
                slivers: [
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Header(),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          EventInfoCard(
                            eventModel: event,
                            title: "Sobre",
                          ),
                          const SizedBox(height: 16),
                          EventInfoCard(
                            eventModel: event,
                            title: "Localização",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Galeria de Fotos",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: _controller
                                            .colorScheme.onSurface,
                                      ),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: _controller
                                      .colorScheme.onPrimaryContainer,
                                ),
                                onPressed: () =>
                                    _openGalleryBottomModal(galleryItems),
                                child: const Text("Ver todas"),
                              ),
                            ],
                          ),
                        ),
                        SliverPhotoGallery(mediaItems: galleryItems),
                      ],
                    ),
                  ),
                  const SliverSafeArea(
                    sliver: SliverToBoxAdapter(
                      child: SizedBox(height: 60),
                    ),
                  ),
                ],
              ),
              StreamValueBuilder<bool>(
                streamValue: _controller.mainBuyButtomIsVisible,
                onNullWidget: const SizedBox.shrink(),
                builder: (context, mainButtonIsVisible) {
                  return AnimatedBottomArea(
                    isVisible: !mainButtonIsVisible,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _calculateThreshold() {
    final renderBox = _controller.mainButtonKey.currentContext
        ?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final widgetBottomEdge = position.dy + renderBox.size.height;
    final threshold = widgetBottomEdge - kToolbarHeight;
    _controller.setVisibilityThreshold(threshold);
  }

  void _openGalleryBottomModal(List<Uri?> mediaItems) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => GalleryBottomModal(mediaItems: mediaItems),
    );
  }

  @override
  void dispose() {
    _controller.onDispose();
    GetIt.I.unregister<EventItemController>();
    super.dispose();
  }
}
