import 'package:flutter/material.dart';

void pushRoute(BuildContext context, Widget screen) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

String displayDuration(Duration d) => "${"${d.inMinutes}".padLeft(2, '0')}:${"${d.inSeconds % 60}".padLeft(2, '0')}";
