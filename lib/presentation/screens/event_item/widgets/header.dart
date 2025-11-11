import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/controller/event_item_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/widgets/event_info_overlay.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/widgets/header_background.dart';
import 'package:belluga_boilerplate/presentation/screens/event_item/widgets/main_button_area.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final _controller = GetIt.I.get<EventItemController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        HeaderBackground(),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    HeaderBackground(),
                    EventInfoOverlay(
                      eventModel: _controller.eventModel,
                    ),
                  ],
                ),
              ),
              MainButtonArea(
                key: _controller.mainButtonKey,
                onButTap: () {},
              )
            ],
          ),
        ),
      ],
    );
  }
}
