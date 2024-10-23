import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:local_fx/src/features/common/domain/enums/app_theme_type.dart';
import 'package:local_fx/src/features/common/presentation/colors.dart';
import 'package:local_fx/src/features/common/presentation/theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

extension AppThemeTypeExtensions on AppThemeType {
  ThemeData get lightTheme {
    return FlexThemeData.light(
      colors: const FlexSchemeColor(
        primary: Color(0xffe88d0e),
        primaryContainer: Color(0xfff7d9af),
        secondary: Color(0xffdb405a),
        secondaryContainer: Color(0xfff8d9de),
        tertiary: Color(0xff006875),
        tertiaryContainer: Color(0xff95f0ff),
        appBarColor: Color(0xfff8d9de),
        error: Color(0xffb00020),
      ),
      usedColors: 4,
      surface: const Color(0xFFFFFFFF),
      scaffoldBackground: const Color(0xFFFFFFFF),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        cardElevation: 0,
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        dialogRadius: 24,
        appBarBackgroundSchemeColor: SchemeColor.background,
        filledButtonSchemeColor: SchemeColor.primaryContainer,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      surfaceTint: Colors.transparent,
      typography: AppTheme.appMaterialTypography,
      textTheme: AppTheme.appMaterialLightTextTheme,
      extensions: <ThemeExtension>[
        SkeletonizerConfigData(
          effect: ShimmerEffect(
            baseColor: AppColors.variantLight,
            highlightColor: AppColors.variantLight.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  ThemeData get darkTheme {
    return FlexThemeData.dark(
      colors: const FlexSchemeColor(
        primary: Color(0xffe88d0e),
        primaryContainer: Color(0xfff7d9af),
        secondary: Color(0xffdb405a),
        secondaryContainer: Color(0xfff8d9de),
        tertiary: Color(0xff006875),
        tertiaryContainer: Color(0xff95f0ff),
        appBarColor: Color(0xfff8d9de),
        error: Color(0xffb00020),
      ).defaultError.toDark(10, true),
      usedColors: 4,
      surface: const Color.fromARGB(255, 20, 20, 20),
      scaffoldBackground: const Color.fromARGB(255, 20, 20, 20),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        cardElevation: 0,
        blendOnLevel: 20,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        dialogRadius: 24,
        appBarBackgroundSchemeColor: SchemeColor.background,
        filledButtonSchemeColor: SchemeColor.primaryContainer,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      surfaceTint: Colors.transparent,
      typography: AppTheme.appMaterialTypography,
      textTheme: AppTheme.appMaterialDarkTextTheme,
      extensions: const <ThemeExtension>[
        SkeletonizerConfigData.dark(),
      ],
    );
  }

  ThemeData get themeData {
    return switch (this) {
      AppThemeType.light => lightTheme,
      AppThemeType.dark => darkTheme,
    };
  }
}
