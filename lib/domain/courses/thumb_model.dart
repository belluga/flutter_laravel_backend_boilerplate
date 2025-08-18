import 'package:belluga_boilerplate/domain/courses/enums/thumb_types.dart';
import 'package:belluga_boilerplate/domain/courses/value_objects/thumb_type_value.dart';
import 'package:belluga_boilerplate/domain/value_objects/thumb_uri_value.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/thumb_dto.dart';

class ThumbModel {
  ThumbTypeValue thumbType;
  ThumbUriValue thumbUri;

  ThumbModel({required this.thumbUri, required this.thumbType});

  factory ThumbModel.fromDTO(ThumbDTO dto) {
    return ThumbModel(
      thumbType:
          ThumbTypeValue(defaultValue: ThumbTypes.values.byName(dto.type)),
      thumbUri: ThumbUriValue(
        defaultValue: Uri.parse(dto.data['url'] as String),
      ),
    );
  }
}
