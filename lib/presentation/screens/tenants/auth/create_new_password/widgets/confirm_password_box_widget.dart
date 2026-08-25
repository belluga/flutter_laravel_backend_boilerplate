import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/widgets/form_field_belluga.dart';

class ConfirmPasswordBoxWidget extends FormFieldBelluga {
  const ConfirmPasswordBoxWidget({
    super.key,
    super.isEnabled,
    required super.formFieldController,
  });

  @override
  String get label => "Confirm password";

  @override
  String get hint => "Repeat your new password";

  @override
  TextInputType get inputType => TextInputType.visiblePassword;

  @override
  bool get obscureText => true;
}
