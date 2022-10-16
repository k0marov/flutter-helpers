import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../general/style.dart';

class CustomTextField extends StatelessWidget {
  final bool enabled;
  final String? label;
  final Function(String) updValue;
  final Either<TextEditingController, String> initial;
  const CustomTextField({
    Key? key,
    required this.enabled,
    required this.label,
    required this.updValue,
    required this.initial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? controller;
    String? initialValue;
    initial.fold(
      (ctrl) => controller = ctrl,
      (val) => initialValue = val,
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.only(top: 12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: fieldFill,
        ),
        child: TextFormField(
          enabled: enabled,
          controller: controller,
          initialValue: initialValue,
          onChanged: updValue,
          decoration: InputDecoration(
            labelText: label,
            hintText: label != null ? "Input your $label" : null,
            contentPadding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 5),
            floatingLabelStyle: labelStyle,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
