enum ThemeBrightness { dark, light, unset }

ThemeBrightness tbFromValue(String? value) => value == null
    ? ThemeBrightness.unset
    : value == lightThemeValue
        ? ThemeBrightness.light
        : ThemeBrightness.dark;
String tbToValue(ThemeBrightness tb) => tb == ThemeBrightness.light ? lightThemeValue : darkThemeValue;

const themeBrightnessSharedPreferencesKey = "THEME_BRIGHTNESS";
const lightThemeValue = "light";
const darkThemeValue = "dark";

// TODO: refactor theme_brightness feature properly
