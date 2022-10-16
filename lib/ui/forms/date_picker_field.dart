import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/entity/entity.dart';
import '../../logic/forms/form_cubit.dart';
import 'form_field_structure.dart';

class DatePickerField<V extends Value> extends StatelessWidget {
  final DateTime current;
  // This should trigger an update higher in the widget tree
  final Function(DateTime) updValue;
  final String label;
  final String Function(DateTime) format;
  final DateTime first;
  final DateTime last;
  const DatePickerField({
    Key? key,
    required this.updValue,
    required this.current,
    required this.label,
    required this.format,
    required this.first,
    required this.last,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormFieldStructure(
      current: format(current),
      label: label,
      onTap: !context.read<FormCubit<V>>().state.isEditing
          ? null
          : () async {
              final chosenDate = await showDatePicker(
                context: context,
                initialDate: current,
                firstDate: first,
                lastDate: last,
              );
              if (chosenDate != null) {
                updValue(chosenDate);
              }
            },
    );
  }
}
