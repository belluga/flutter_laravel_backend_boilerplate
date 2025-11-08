import 'package:belluga_boilerplate/application/extensions/enum_functions.dart';
import 'package:flutter/material.dart';
import 'package:value_object_pattern/value_object.dart';

class BrightnessValue extends ValueObject<Brightness> {
  BrightnessValue({
    super.defaultValue = Brightness.light,
    super.isRequired = true,
  });

  @override
  Brightness doParse(String? parseValue) =>
      Brightness.values.byNameOr(name: parseValue, or: Brightness.light);
}
