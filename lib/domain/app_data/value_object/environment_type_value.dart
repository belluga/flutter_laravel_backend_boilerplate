import 'package:belluga_boilerplate/application/extensions/enum_functions.dart';
import 'package:belluga_boilerplate/domain/app_data/environment_type.dart';
import 'package:value_object_pattern/value_object.dart';

class EnvironmentTypeValue extends ValueObject<EnvironmentType> {
  EnvironmentTypeValue({
    super.defaultValue = EnvironmentType.landlord,
    super.isRequired = true,
  });

  @override
  EnvironmentType doParse(String? parseValue) =>
      EnvironmentType.values.byNameOr(name: parseValue, or: EnvironmentType.landlord);
}
