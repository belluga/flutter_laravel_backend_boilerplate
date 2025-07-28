import 'package:unifast_portal/domain/schedule/event_action_types.dart';
import 'package:unifast_portal/domain/schedule/value_objects/event_action_type_value.dart';
import 'package:unifast_portal/domain/value_objects/color_value.dart';
import 'package:unifast_portal/domain/value_objects/title_value.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_actions_dto.dart';
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

    final EventActionTypes _type = EventActionTypes.values.byName(dto.type);

    return switch (_type) {
      EventActionTypes.externalUrl => EventActionExternalUrl(
          id: _id,
          label: _label,
          color: _color,
          externalUrl: URIValue()..tryParse(dto.externalUrl),
          // openIn: dto.openIn,
        ),
      EventActionTypes.courseItem => EventActionCourseNavigation(
          id: _id,
          label: _label,
          color: _color,
          itemType: EventActionTypeValue()..parse(dto.itemType),
          itemId: MongoIDValue()..tryParse(dto.itemId),
        ),
    };
  }
}

class EventActionExternalUrl extends EventActionModel {
  final URIValue externalUrl;

  EventActionExternalUrl({
    required super.id,
    required super.label,
    required super.color,
    required this.externalUrl,
  });
}

abstract class EventActionAppContentNavigation extends EventActionModel {
  final MongoIDValue itemId;
  final EventActionTypeValue itemType;

  EventActionAppContentNavigation({
    required super.id,
    required super.label,
    required super.color,
    required this.itemId,
    required this.itemType,
  });
}

class EventActionCourseNavigation extends EventActionAppContentNavigation {
  EventActionCourseNavigation({
    required super.id,
    required super.label,
    required super.color,
    required super.itemId,
    required super.itemType,
  }) : assert(itemType.value == EventActionTypes.courseItem);
}
