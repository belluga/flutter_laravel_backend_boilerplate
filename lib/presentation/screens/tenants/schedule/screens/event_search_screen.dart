import 'package:belluga_boilerplate/domain/schedule/event_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/controller/event_search_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/schedule/widgets/event_card.dart';
import 'package:belluga_boilerplate/presentation/widgets/icon_button_toggled.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class EventSearchScreen extends StatefulWidget {
  const EventSearchScreen({super.key});

  @override
  State<EventSearchScreen> createState() => _EventSearchScreenState();
}

class _EventSearchScreenState extends State<EventSearchScreen> {
  final _controller = GetIt.I.get<EventSearchScreenController>();

  @override
  void initState() {
    super.initState();
    _controller.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller.searchController,
          focusNode: _controller.focusNode,
          style: theme.textTheme.titleMedium,
          decoration: InputDecoration(
            hintText: 'Buscar eventos...',
            border: InputBorder.none,
            hintStyle: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withAlpha((0.6 * 255 ).floor()),
            ),
          ),
          onChanged: _controller.searchEvents,
        ),
        actionsPadding: EdgeInsets.only(right: 8),
        actions: [
          IconButtonToggled(
            selectedStateStreamValue: _controller.showHistoryStreamValue,
            toggleFunction: _controller.toggleHistory,
            iconData: Icons.history,
            selectedTooltip: 'Ocultar eventos já finalizados',
            unselectedTooltip: 'Mostrar eventos já finalizados',
          ),
        ],
      ),
      body: StreamValueBuilder<List<EventModel>>(
        streamValue: _controller.searchResultsStreamValue,
        onNullWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (context, events) {
          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: colorScheme.onSurfaceVariant
                        .withAlpha((0.5 * 255).floor()),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum resultado encontrado',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return _buildGroupedEvents(context, events);
        },
      ),
    );
  }

  Widget _buildGroupedEvents(BuildContext context, List<EventModel> events) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Group events by date
    final Map<String, List<EventModel>> groupedEvents = {};
    for (var event in events) {
      final dateKey =
          DateFormat('yyyy-MM-dd').format(event.dateTimeStart.value!);
      if (!groupedEvents.containsKey(dateKey)) {
        groupedEvents[dateKey] = [];
      }
      groupedEvents[dateKey]!.add(event);
    }

    // Sort dates
    final sortedDates = groupedEvents.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final dateKey = sortedDates[index];
        final dateEvents = groupedEvents[dateKey]!;
        final date = DateTime.parse(dateKey);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date divider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(color: colorScheme.outlineVariant),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      DateFormat.MMMMEEEEd().format(date),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: colorScheme.outlineVariant),
                  ),
                ],
              ),
            ),
            // Events for this date
            ...dateEvents.map((event) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: EventCard(event: event),
                )),
          ],
        );
      },
    );
  }
}
