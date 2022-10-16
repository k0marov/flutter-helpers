import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import 'theme_brightness.dart';

typedef GetThemeBrightnessStreamUseCase = Stream<ThemeBrightness> Function();

GetThemeBrightnessStreamUseCase newGetThemeBrightnessUseCase(RxSharedPreferences sp) => () {
      return sp.getStringStream(themeBrightnessSharedPreferencesKey).map(tbFromValue);
    };
