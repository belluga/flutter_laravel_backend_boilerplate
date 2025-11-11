import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/main.dart';
import 'package:festou_app/domain/thumb/gallery_item_model.dart';
import 'package:festou_app/presentation/screens/event_item/bottom_modals/gallery_bottom_modal.dart';
import 'package:festou_app/presentation/screens/event_item/controller/event_item_controller.dart';
import 'package:festou_app/presentation/screens/event_item/widgets/animated_bottom_area.dart';
import 'package:festou_app/presentation/screens/event_item/widgets/color_scheme_viewer.dart';
import 'package:festou_app/presentation/screens/event_item/widgets/event_info_card.dart';
import 'package:festou_app/presentation/screens/event_item/widgets/header.dart';
import 'package:festou_app/presentation/screens/event_item/widgets/sliver_photo_gallery.dart';

@RoutePage()
class EventItemScreen extends StatefulWidget {
  final String eventSlug;

  const EventItemScreen(
      {super.key, @PathParam("event_slug") required this.eventSlug});

  @override
  State<EventItemScreen> createState() => _EventItemScreenState();
}

class _EventItemScreenState extends State<EventItemScreen> {
  late EventItemController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamValueBuilder(
        streamValue: _controller.eventStreamValue,
        onNullWidget: Center(
          child: CircularProgressIndicator(),
        ),
        builder: (context, asyncSnapshot) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _calculateThreshold();
          });

          final List<GalleryItemModel> _mediaItems = [
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
          ];

          return Scaffold(
            backgroundColor: _controller.colorScheme.primary,
            
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                    controller: _controller.scrollController,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Header(),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            children: [
                              EventInfoCard(
                                eventModel: _controller.eventModel,
                                title: "Sobre",
                              ),
                              EventInfoCard(
                                eventModel: _controller.eventModel,
                                title: "Localização",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        sliver: SliverMainAxisGroup(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Galeria de Fotos",
                                      style: TextTheme.of(context)
                                          .labelLarge
                                          ?.copyWith(
                                            color: _controller.colorScheme.onSurface,
                                          ),
                                    ),
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: _controller
                                            .colorScheme.onPrimaryContainer,
                                      ),
                                      onPressed: _openGalleryBottomModal,
                                      child: Text("Ver todas"))
                                ],
                              ),
                            ),
                            SliverPhotoGallery(
                              mediaItems: _mediaItems,
                            ),
                          ],
                        ),
                      ),
                      SliverSafeArea(
                        sliver: SliverToBoxAdapter(
                          child: SizedBox(height: 60),
                        ),
                      ),
                    ]),
                StreamValueBuilder<bool>(
                  streamValue: _controller.mainBuyButtomIsVisible,
                  onNullWidget: SizedBox.shrink(),
                  builder: (context, mainButtonIsVisible) {
                    return AnimatedBottomArea(
                      isVisible: !mainButtonIsVisible,
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  void _calculateThreshold() {
    final RenderBox? renderBox = _controller.mainButtonKey.currentContext
        ?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final widgetBottomEdge = position.dy + renderBox.size.height;
      final threshold = widgetBottomEdge - kToolbarHeight;

      _controller.setVisibilityThreshold(threshold);
    }
  }

  void _initializeController() {
    _controller = GetIt.I.registerSingleton<EventItemController>(
        EventItemController(eventSlug: widget.eventSlug));
  }

  void _openGalleryBottomModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return GalleryBottomModal(
          mediaItems: [
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
            _controller.eventModel.thumb,
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    GetIt.I.unregister<EventItemController>();
  }
}
