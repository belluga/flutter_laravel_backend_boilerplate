import 'package:value_object_pattern/value_object.dart';

class UseMaterial3Value extends ValueObject<bool> {
  UseMaterial3Value({
    super.defaultValue = true,
    super.isRequired = true,
  });

  @override
  bool doParse(String? parseValue) => bool.parse(parseValue ?? "1");
}
