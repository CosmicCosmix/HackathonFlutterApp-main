import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Display Styles
  // Large text styles typically used for headers and hero elements

  TextStyle get display36BoldMerriweather => TextStyle(
        fontSize: 36.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Merriweather',
        color: appTheme.white_A700,
      );

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline24BlackMerriweather => TextStyle(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w900,
        fontFamily: 'Merriweather',
        color: appTheme.white_A700,
      );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  // Other Styles
  // Miscellaneous text styles without specified font size

  TextStyle get bodyTextMerriweather => TextStyle(
        fontFamily: 'Merriweather',
      );
}
