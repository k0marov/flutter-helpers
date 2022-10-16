import 'package:flutter/material.dart';

class FormSectionWidget extends StatelessWidget {
  final String title;
  final Widget updButton;
  final List<Widget> fields;

  const FormSectionWidget(
      {Key? key, required this.title, required this.updButton, required this.fields})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        color: Colors.grey[800], // TODO: make this a constant
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(child: Align(alignment: Alignment.centerRight, child: updButton)),
              ],
            ),
          ),
          ...fields,
        ]));
  }
}
