import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/enums/app_language_type.dart';
import 'package:local_fx/src/features/common/domain/models/language/language.dart';
import 'package:local_fx/src/features/common/infrastructure/preference_service.dart';

class LocaleService {
  LocaleService(this._preferenceService);

  final PreferenceService _preferenceService;

  String getFormattedLocale(AppLanguageType language) {
    final locale = getLocale(language);
    return '${locale.code}_${locale.countryCode}';
  }

  Language getLocaleWithoutLang() {
    return getLocale(_preferenceService.language);
  }

  Language getLocale(AppLanguageType language) {
    if (!languagesMap.entries.any((kvp) => kvp.key == language)) {
      throw Exception('The language = $language is not a valid value');
    }

    return languagesMap.entries.firstWhere((kvp) => kvp.key == language).value;
  }
}
