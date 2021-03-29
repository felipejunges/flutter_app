import 'dart:core';

import 'package:flutter/material.dart';

class CampoForm extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool password;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  CampoForm(
    this.label,
    this.hint, {
    @required this.controller,
    this.password = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
