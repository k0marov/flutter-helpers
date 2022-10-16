import 'package:flutter/material.dart';

import '../../logic/theme_brightness/get_theme_brightness_stream_usecase.dart';
import '../../logic/theme_brightness/theme_brightness.dart';

class BrightnessBuilder extends StatelessWidget {
  final GetThemeBrightnessStreamUseCase getBrightnessStream;
  final Widget Function(BuildContext, ThemeMode) builder;
  const BrightnessBuilder({
    Key? key,
    required this.getBrightnessStream,
    required this.builder,
  }) : super(key: key);

  ThemeMode _getThemeMode(ThemeBrightness brightness) {
    switch (brightness) {
      case ThemeBrightness.dark:
        return ThemeMode.dark;
      case ThemeBrightness.light:
        return ThemeMode.light;
      case ThemeBrightness.unset:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeBrightness>(
      stream: getBrightnessStream(),
      builder: (context, brightness) => builder(
        context,
        _getThemeMode(brightness.data ?? ThemeBrightness.unset),
      ),
    );
  }
}
