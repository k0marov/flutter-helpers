import 'package:flutter/material.dart';

import '../general/style.dart';

class FormFieldStructure extends StatelessWidget {
  final String current;
  final String label;
  final Function()? onTap;

  final Widget? postfix;

  const FormFieldStructure({
    Key? key,
    this.postfix,
    required this.current,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
            decoration: const BoxDecoration(
              color: fieldFill,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      textScaleFactor: 0.8,
                      style: labelStyle,
                    ),
                    const SizedBox(height: 7),
                    Text(current),
                  ],
                ),
                const Spacer(),
                if (postfix != null) postfix!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
