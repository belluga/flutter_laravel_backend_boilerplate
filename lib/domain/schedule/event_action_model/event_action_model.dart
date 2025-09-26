import 'package:flutter/cupertino.dart';
import 'package:belluga_boilerplate/domain/schedule/event_action_item_types.dart';
import 'package:belluga_boilerplate/domain/schedule/event_action_model/event_action_external_navigation.dart';
import 'package:belluga_boilerplate/domain/schedule/event_action_model/event_action_course_navigation.dart';
import 'package:belluga_boilerplate/domain/schedule/event_action_types.dart';
import 'package:belluga_boilerplate/domain/schedule/value_objects/event_action_item_type_value.dart';
import 'package:belluga_boilerplate/domain/value_objects/color_value.dart';
import 'package:belluga_boilerplate/domain/value_objects/title_value.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/schedule/event_actions_dto.dart';
import 'package:value_object_pattern/domain/value_objects/mongo_id_value.dart';
import 'package:value_object_pattern/domain/value_objects/uri_value.dart';

abstract class EventActionModel {
  final MongoIDValue? id;
  final TitleValue label;
  final ColorValue? color;

  EventActionModel({
    required this.id,
    required this.label,
    required this.color,
  });

  static EventActionModel fromDTO(EventActionsDTO dto) {
    final MongoIDValue _id = MongoIDValue()..tryParse(dto.id);
    final TitleValue _label = TitleValue()..parse(dto.label);
    final ColorValue _color = ColorValue()..tryParse(dto.color);

    final EventActionTypes _openIn = EventActionTypes.values.byName(dto.openIn);

    switch (_openIn) {
      case EventActionTypes.external:
        return EventActionExternalNavigation(
          id: _id,
          label: _label,
          color: _color,
          externalUrl: URIValue()..tryParse(dto.externalUrl),
        );
      case EventActionTypes.inApp:
        final _itemType = EventActionItemTypes.values.byName(dto.itemType!);
        return switch (_itemType) {
          EventActionItemTypes.courseItem => EventActionCourseNavigation(
              id: _id,
              label: _label,
              color: _color,
              itemType: EventActionItemTypeValue()..parse(dto.itemType),
              itemId: MongoIDValue()..tryParse(dto.itemId),
            )
        };
    }
  }

  void open(BuildContext context);
}