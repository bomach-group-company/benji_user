// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/colors.dart';

class MyFlexTextFormField extends StatelessWidget {
  final TextInputAction textInputAction;
  final TextEditingController controller;

  final dynamic onSaved;
  final dynamic validator;
  final dynamic onChanged;
  final String hintText;
  const MyFlexTextFormField({
    super.key,
    required this.controller,
    required this.textInputAction,
    required this.onSaved,
    required this.validator,
    this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textInputAction: textInputAction,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        errorStyle: const TextStyle(
          color: kErrorColor,
        ),
        filled: true,
        fillColor: Colors.blue.shade50,
        focusColor: Colors.blue.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide(
            color: Colors.blue.shade50,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide(
            color: Colors.blue.shade50,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide(
            color: Colors.blue.shade50,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: const BorderSide(
            color: kErrorBorderColor,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: const BorderSide(
            color: kErrorBorderColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
