import 'package:unifast_portal/domain/courses/value_objects/slug_value.dart';
import 'package:unifast_portal/domain/value_objects/color_value.dart';
import 'package:unifast_portal/domain/value_objects/description_value.dart';
import 'package:unifast_portal/domain/value_objects/title_value.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_type_dto.dart';
import 'package:value_object_pattern/domain/value_objects/mongo_id_value.dart';

class EventTypeModel {
  final MongoIDValue id;
  final TitleValue name;
  final SlugValue slug;
  final DescriptionValue description;
  final SlugValue icon;
  final ColorValue color;

  EventTypeModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.icon,
    required this.color,
  });

  factory EventTypeModel.fromDTO(EventTypeDTO dto) {
    return EventTypeModel(
      id: MongoIDValue()..tryParse(dto.id),
      name: TitleValue()..parse(dto.name),
      slug: SlugValue()..parse(dto.slug),
      description: DescriptionValue()..parse(dto.description),
      icon: SlugValue()..tryParse(dto.icon),
      color: ColorValue()..tryParse(dto.color),
    );
  }

}