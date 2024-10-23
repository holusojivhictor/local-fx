import 'package:flutter/material.dart';

class AppTheme {
  static Typography appMaterialTypography = Typography(
    black: appMaterialBlackTheme,
    white: appMaterialWhiteTheme,
    englishLike: appMaterialEnglishLikeTextTheme,
    dense: appMaterialDenseTextTheme,
    tall: appMaterialTallTextTheme,
  );

  static const fontFamily = 'Jost';

  static TextTheme appMaterialBlackTheme = const TextTheme(
    displayLarge: TextStyle(debugLabel: 'blackJost displayLarge', fontFamily: fontFamily, color: Colors.black54, decoration: TextDecoration.none,),
    displayMedium: TextStyle(debugLabel: 'blackJost displayMedium', fontFamily: fontFamily, color: Colors.black54, decoration: TextDecoration.none,),
    displaySmall: TextStyle(debugLabel: 'blackJost displaySmall', fontFamily: fontFamily, color: Colors.black54, decoration: TextDecoration.none,),
    headlineLarge: TextStyle(debugLabel: 'blackJost headlineLarge', fontFamily: fontFamily, color: Colors.black54, decoration: TextDecoration.none,),
    headlineMedium: TextStyle(debugLabel: 'blackJost headlineMedium', fontFamily: fontFamily, color: Colors.black54, decoration: TextDecoration.none,),
    headlineSmall: TextStyle(debugLabel: 'blackJost headlineSmall', fontFamily: fontFamily, color: Colors.black87, decoration: TextDecoration.none,),
    titleLarge: TextStyle(debugLabel: 'blackJost titleLarge', fontFamily: fontFamily, color: Colors.black87, decoration: TextDecoration.none,),
    titleMedium: TextStyle(debugLabel: 'blackJost titleMedium', fontFamily: fontFamily, color:Colors.black87, decoration: TextDecoration.none, ),
    titleSmall: TextStyle(debugLabel: 'blackJost titleSmall', fontFamily: fontFamily, color: Colors.black, decoration: TextDecoration.none,),
    bodyLarge: TextStyle(debugLabel: 'blackJost bodyLarge', fontFamily: fontFamily, color: Colors.black87, decoration: TextDecoration.none,),
    bodyMedium: TextStyle(debugLabel: 'blackJost bodyMedium', fontFamily: fontFamily, color: Colors.black87, decoration: TextDecoration.none,),
    bodySmall: TextStyle(debugLabel: 'blackJost bodySmall', fontFamily: fontFamily, color: Colors.black54, decoration: TextDecoration.none,),
    labelLarge: TextStyle(debugLabel: 'blackJost labelLarge', fontFamily: fontFamily, color: Colors.black87, decoration: TextDecoration.none,),
    labelMedium: TextStyle(debugLabel: 'blackJost labelMedium', fontFamily: fontFamily, color: Colors.black, decoration: TextDecoration.none,),
    labelSmall: TextStyle(debugLabel: 'blackJost labelSmall', fontFamily: fontFamily, color: Colors.black, decoration: TextDecoration.none,),
  );

  static TextTheme appMaterialWhiteTheme = const TextTheme(
    displayLarge: TextStyle(debugLabel: 'whiteJost displayLarge', fontFamily: fontFamily, color: Colors.white70, decoration: TextDecoration.none,),
    displayMedium: TextStyle(debugLabel: 'whiteJost displayMedium', fontFamily: fontFamily, color: Colors.white70, decoration: TextDecoration.none,),
    displaySmall: TextStyle(debugLabel: 'whiteJost displaySmall', fontFamily: fontFamily, color: Colors.white70, decoration: TextDecoration.none,),
    headlineLarge: TextStyle(debugLabel: 'whiteJost headlineLarge', fontFamily: fontFamily, color: Colors.white70, decoration: TextDecoration.none,),
    headlineMedium: TextStyle(debugLabel: 'whiteJost headlineMedium', fontFamily: fontFamily, color: Colors.white70, decoration: TextDecoration.none,),
    headlineSmall: TextStyle(debugLabel: 'whiteJost headlineSmall', fontFamily: fontFamily, color: Colors.white, decoration: TextDecoration.none,),
    titleLarge: TextStyle(debugLabel: 'whiteJost titleLarge', fontFamily: fontFamily, color: Colors.white, decoration: TextDecoration.none,),
    titleMedium: TextStyle(debugLabel: 'whiteJost titleMedium', fontFamily: fontFamily, color:Colors.white, decoration: TextDecoration.none, ),
    titleSmall: TextStyle(debugLabel: 'whiteJost titleSmall', fontFamily: fontFamily, color: Colors.white, decoration: TextDecoration.none,),
    bodyLarge: TextStyle(debugLabel: 'whiteJost bodyLarge', fontFamily: fontFamily, color: Colors.white, decoration: TextDecoration.none,),
    bodyMedium: TextStyle(debugLabel: 'whiteJost bodyMedium', fontFamily: fontFamily, color: Colors.white, decoration: TextDecoration.none,),
    bodySmall: TextStyle(debugLabel: 'whiteJost bodySmall', fontFamily: fontFamily, color: Colors.white70, decoration: TextDecoration.none,),
    labelLarge: TextStyle(debugLabel: 'whiteJost labelLarge', fontFamily: fontFamily, color: Colors.white, decoration: TextDecoration.none,),
    labelMedium: TextStyle(debugLabel: 'whiteJost labelMedium', fontFamily: fontFamily, color: Colors.white, decoration: TextDecoration.none,),
    labelSmall: TextStyle(debugLabel: 'whiteJost labelSmall', fontFamily: fontFamily, color: Colors.white, decoration: TextDecoration.none,),
  );

  static TextTheme appMaterialEnglishLikeTextTheme = const TextTheme(
    displayLarge: TextStyle(debugLabel: 'englishLike displayLarge ', fontSize: 96, fontWeight: FontWeight.w300, textBaseline: TextBaseline.alphabetic, letterSpacing: -1.5, ),
    displayMedium: TextStyle(debugLabel: 'englishLike displayMedium', fontSize: 60, fontWeight: FontWeight.w300, textBaseline: TextBaseline.alphabetic, letterSpacing: -0.5,),
    displaySmall: TextStyle(debugLabel: 'englishLike displaySmall', fontSize: 48, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing: 0,),
    headlineLarge: TextStyle(debugLabel: 'englishLike headlineLarge', fontSize: 40, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing: 0.25,),
    headlineMedium: TextStyle(debugLabel: 'englishLike headlineMedium', fontSize: 34, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing: 0.25,),
    headlineSmall: TextStyle(debugLabel: 'englishLike headlineSmall', fontSize: 24, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing:0,),
    titleLarge: TextStyle(debugLabel: 'englishLike titleLarge', fontSize: 22, fontWeight: FontWeight.w500, textBaseline: TextBaseline.alphabetic, letterSpacing: 0.15,),
    titleMedium: TextStyle(debugLabel: 'englishLike titleMedium', fontSize: 16, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing: 0.15,),
    titleSmall: TextStyle(debugLabel: 'englishLike titleSmall', fontSize: 14, fontWeight: FontWeight.w500, textBaseline: TextBaseline.alphabetic, letterSpacing: 0.1,),
    bodyLarge: TextStyle(debugLabel: 'englishLike bodyLarge', fontSize: 16, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing: 0.5,),
    bodyMedium: TextStyle(debugLabel: 'englishLike bodyMedium', fontSize: 14, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing: 0.25,),
    bodySmall: TextStyle(debugLabel: 'englishLike bodySmall', fontSize: 12, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing: 0.4,),
    labelLarge: TextStyle(debugLabel: 'englishLike labelLarge', fontSize: 14, fontWeight: FontWeight.w500, textBaseline: TextBaseline.alphabetic, letterSpacing: 1.25,),
    labelMedium: TextStyle(debugLabel: 'englishLike labelMedium', fontSize: 11, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing: 1.5,),
    labelSmall: TextStyle(debugLabel: 'englishLike labelSmall', fontSize: 10, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic, letterSpacing: 1.5,),
  );

  static TextTheme appMaterialDenseTextTheme = const TextTheme(
    displayLarge: TextStyle(debugLabel: 'dense displayLarge', inherit: false, fontSize: 112, fontWeight: FontWeight.w100, textBaseline: TextBaseline.ideographic,),
    displayMedium: TextStyle(debugLabel: 'dense displayMedium', inherit: false, fontSize: 56, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    displaySmall: TextStyle(debugLabel: 'dense displaySmall', inherit: false, fontSize: 45, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    headlineLarge: TextStyle(debugLabel: 'dense headlineLarge',inherit: false, fontSize: 40, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    headlineMedium: TextStyle(debugLabel: 'dense headlineMedium', inherit: false, fontSize: 34, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    headlineSmall: TextStyle(debugLabel: 'dense headlineSmall', inherit: false, fontSize: 24, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    titleLarge: TextStyle(debugLabel: 'dense titleLarge', inherit: false, fontSize: 23, fontWeight: FontWeight.w500, textBaseline: TextBaseline.ideographic,),
    titleMedium: TextStyle(debugLabel: 'dense titleMedium', inherit: false, fontSize: 17, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    titleSmall: TextStyle(debugLabel: 'dense titleSmall', inherit: false, fontSize: 15, fontWeight: FontWeight.w500, textBaseline: TextBaseline.ideographic,),
    bodyLarge: TextStyle(debugLabel: 'dense bodyLarge', inherit: false, fontSize: 15, fontWeight: FontWeight.w500, textBaseline: TextBaseline.ideographic,),
    bodyMedium: TextStyle(debugLabel: 'dense bodyMedium', inherit: false, fontSize: 15, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    bodySmall: TextStyle(debugLabel: 'dense bodySmall', inherit: false, fontSize: 13, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    labelLarge: TextStyle(debugLabel: 'dense labelLarge', inherit: false, fontSize: 15, fontWeight: FontWeight.w500, textBaseline: TextBaseline.ideographic,),
    labelMedium: TextStyle(debugLabel: 'dense labelMedium', inherit: false, fontSize: 12, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    labelSmall: TextStyle(debugLabel: 'dense labelSmall', inherit: false, fontSize: 11, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
  );

  static TextTheme appMaterialTallTextTheme = const TextTheme(
    displayLarge: TextStyle(debugLabel: 'tall displayLarge', inherit: false, fontSize: 112, fontWeight: FontWeight.w400, textBaseline: TextBaseline.alphabetic,),
    displayMedium: TextStyle(debugLabel: 'tall displayMedium', inherit: false, fontSize: 56, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    displaySmall: TextStyle(debugLabel: 'tall displaySmall', inherit: false, fontSize: 45, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    headlineLarge: TextStyle(debugLabel: 'tall headlineLarge', inherit: false, fontSize: 40, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    headlineMedium: TextStyle(debugLabel: 'tall headlineMedium', inherit: false, fontSize: 34, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    headlineSmall: TextStyle(debugLabel: 'tall headlineSmall', inherit: false, fontSize: 24, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    titleLarge: TextStyle(debugLabel: 'tall titleLarge', inherit: false, fontSize: 24, fontWeight: FontWeight.w700, textBaseline: TextBaseline.ideographic,),
    titleMedium: TextStyle(debugLabel: 'tall titleMedium', inherit: false, fontSize: 21, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    titleSmall: TextStyle(debugLabel: 'tall titleSmall', inherit: false, fontSize: 17, fontWeight: FontWeight.w500, textBaseline: TextBaseline.ideographic,),
    bodyLarge: TextStyle(debugLabel: 'tall bodyLarge', inherit: false, fontSize: 15, fontWeight: FontWeight.w700, textBaseline: TextBaseline.ideographic,),
    bodyMedium: TextStyle(debugLabel: 'tall bodyMedium', inherit: false, fontSize: 15, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    bodySmall: TextStyle(debugLabel: 'tall bodySmall', inherit: false, fontSize: 13, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    labelLarge: TextStyle(debugLabel: 'tall labelLarge', inherit: false, fontSize: 15, fontWeight: FontWeight.w700, textBaseline: TextBaseline.ideographic,),
    labelMedium: TextStyle(debugLabel: 'tall labelMedium', inherit: false, fontSize: 12, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
    labelSmall: TextStyle(debugLabel: 'tall labelSmall', inherit: false, fontSize: 11, fontWeight: FontWeight.w400, textBaseline: TextBaseline.ideographic,),
  );

  static TextTheme appMaterialLightTextTheme = const TextTheme(
    displayLarge: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.w900,),
    displayMedium: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800,),
    displaySmall: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w600,),
    headlineLarge: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w900,),
    headlineMedium: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800),
    headlineSmall: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontStyle: FontStyle.normal),
    bodyMedium: TextStyle(fontStyle: FontStyle.normal),
    bodySmall: TextStyle(fontStyle: FontStyle.normal),
    labelLarge: TextStyle(fontStyle: FontStyle.normal),
    labelMedium: TextStyle(fontStyle: FontStyle.normal),
    labelSmall: TextStyle(fontStyle: FontStyle.normal),
  );

  static TextTheme appMaterialDarkTextTheme = const TextTheme(
    displayLarge: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w900,),
    displayMedium: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800,),
    displaySmall: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w600,),
    headlineLarge: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w900,),
    headlineMedium: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800,),
    headlineSmall: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w600,),
    bodyLarge: TextStyle(fontStyle: FontStyle.normal,),
    bodyMedium: TextStyle(fontStyle: FontStyle.normal),
    bodySmall: TextStyle(fontStyle: FontStyle.normal),
    labelLarge: TextStyle(fontStyle: FontStyle.normal),
    labelMedium: TextStyle(fontStyle: FontStyle.normal),
    labelSmall: TextStyle(fontStyle: FontStyle.normal),
  );
}
