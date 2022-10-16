import 'package:flutter/material.dart';

import '../../logic/errors/errors.dart';
import '../../logic/general.dart';

void showExceptionSnackbar(BuildContext context, Exception e) {
  printDebug("showing a snackbar");
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Text(displayException(e), style: const TextStyle(color: Colors.white)),
        const Spacer(),
        TextButton(
          child: const Text("Dismiss"),
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ],
    ),
    backgroundColor: Colors.red,
  ));
}
