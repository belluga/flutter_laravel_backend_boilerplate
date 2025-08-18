import 'package:unifast_portal/domain/schedule/event_action_model/event_action_model.dart';
import 'package:unifast_portal/domain/schedule/value_objects/event_action_Item_type_value.dart';
import 'package:value_object_pattern/domain/value_objects/mongo_id_value.dart';

abstract class EventActionInAppNavigation extends EventActionModel {
  final MongoIDValue itemId;
  final EventActionItemTypeValue itemType;

  EventActionInAppNavigation({
    required super.id,
    required super.label,
    required super.color,
    required this.itemId,
    required this.itemType,
  });
}