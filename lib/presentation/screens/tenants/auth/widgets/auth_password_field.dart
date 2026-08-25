import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/auth/widgets/form_field_belluga.dart';

class AuthPasswordField extends FormFieldBelluga {
  const AuthPasswordField({
    super.key,
    super.isEnabled,
    required super.formFieldController,
  });

  @override
  String get label => "Password";

  @override
  String get hint => "Enter your password";

  @override
  TextInputType get inputType => TextInputType.visiblePassword;

  @override
  bool get obscureText => true;
}
