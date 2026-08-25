import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/widgets/form_field_belluga.dart';

class AuthEmailField extends FormFieldBelluga {
  const AuthEmailField({
    super.key,
    super.isEnabled,
    required super.formFieldController,
  });

  @override
  String get label => "Email";

  @override
  String get hint => "your.email@example.com";

  @override
  TextInputType get inputType => TextInputType.emailAddress;
}
