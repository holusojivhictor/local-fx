import 'package:flutter/widgets.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';

enum AppThemeType {
  light,
  dark;

  String translate(BuildContext context) {
    final s = S.of(context);
    return switch (this) {
      AppThemeType.light => s.light,
      AppThemeType.dark => s.dark,
    };
  }
}
