import 'package:belluga_boilerplate/domain/value_objects/url_required_value.dart';

class DomainValue extends URIRequiredValue {
  DomainValue({
    required super.defaultValue,
    super.isRequired = true,
  });
}