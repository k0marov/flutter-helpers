import 'package:dartz/dartz.dart' show Left;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/entity/entity.dart';
import '../../logic/forms/form_cubit.dart';
import 'custom_text_field.dart';

class CustomFormTextField<V extends Value> extends StatefulWidget {
  final String? Function(V) getValue;
  final Function(String) updValue;
  final String? label;
  const CustomFormTextField({
    Key? key,
    required this.label,
    required this.getValue,
    required this.updValue,
  }) : super(key: key);

  @override
  State<CustomFormTextField<V>> createState() => _CustomFormTextFieldState<V>();
}

class _CustomFormTextFieldState<V extends Value> extends State<CustomFormTextField<V>> {
  late final TextEditingController _controller;
  @override
  void initState() {
    final currentText = _stateToText(context.read<FormCubit<V>>().state);
    _controller = TextEditingController(text: currentText);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _stateToText(FormCubitState<V> state) {
    if (state.val != null) {
      return widget.getValue(state.val!) ?? "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormCubit<V>, FormCubitState<V>>(
      listener: (context, state) {
        final text = _stateToText(state);
        _controller.value = TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      },
      listenWhen: (prev, curr) => _stateToText(prev) != _stateToText(curr),
      child: CustomTextField(
        enabled: context.read<FormCubit<V>>().state.isEditing,
        label: widget.label,
        updValue: widget.updValue,
        initial: Left(_controller),
      ),
    );
  }
}
