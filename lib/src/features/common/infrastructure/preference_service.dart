import 'package:collection/collection.dart' show IterableExtension;
import 'package:devicelocale/devicelocale.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/enums/enums.dart';
import 'package:local_fx/src/features/common/domain/models/preferences/preferences.dart';
import 'package:local_fx/src/features/common/infrastructure/logging_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  PreferenceService(this._logger);

  bool _initialized = false;

  late SharedPreferences _prefs;
  final LoggingService _logger;

  final _appThemeKey = 'AppTheme';
  final _appLanguageKey = 'AppLanguage';
  final _isFirstInstallKey = 'FirstInstall';
  final _autoThemeModeKey = 'AutoThemeMode';

  AppThemeType get appTheme =>
      AppThemeType.values[_prefs.getInt(_appThemeKey)!];

  set appTheme(AppThemeType theme) => _prefs.setInt(_appThemeKey, theme.index);

  AppLanguageType get language =>
      AppLanguageType.values[_prefs.getInt(_appLanguageKey)!];

  set language(AppLanguageType lang) =>
      _prefs.setInt(_appLanguageKey, lang.index);

  bool get isFirstInstall => _prefs.getBool(_isFirstInstallKey)!;

  set isFirstInstall(bool itIs) => _prefs.setBool(_isFirstInstallKey, itIs);

  AutoThemeModeType get autoThemeMode =>
      AutoThemeModeType.values[_prefs.getInt(_autoThemeModeKey)!];

  set autoThemeMode(AutoThemeModeType themeMode) =>
      _prefs.setInt(_autoThemeModeKey, themeMode.index);

  Preferences get preferences => Preferences(
    appTheme: appTheme,
    appLanguage: language,
    isFirstInstall: isFirstInstall,
    themeMode: autoThemeMode,
  );

  Future<void> init() async {
    if (_initialized) {
      _logger.info(runtimeType, 'Preferences are already initialized!');
      return;
    }

    _logger.info(
      runtimeType,
      'Initializing preferences...Getting shared preferences instance...',
    );

    _prefs = await SharedPreferences.getInstance();

    if (_prefs.get(_isFirstInstallKey) == null) {
      _logger.info(runtimeType, 'This is the first install of the app');
      isFirstInstall = true;
    } else {
      isFirstInstall = false;
    }

    if (_prefs.get(_appThemeKey) == null) {
      _logger.info(runtimeType, 'Setting light as the default theme');
      appTheme = AppThemeType.light;
    }

    if (_prefs.get(_appLanguageKey) == null) {
      language = await _getDefaultLangToUse();
    }

    if (_prefs.get(_autoThemeModeKey) == null) {
      _logger.info(runtimeType, 'Auto theme mode set to false as default');
      autoThemeMode = AutoThemeModeType.off;
    }

    _initialized = true;
    _logger.info(runtimeType, 'Preferences were initialized successfully');
  }

  Future<AppLanguageType> _getDefaultLangToUse() async {
    try {
      _logger.info(
        runtimeType,
        '_getDefaultLangToUse: Trying to retrieve device lang...',
      );
      final deviceLocale = await Devicelocale.currentAsLocale;
      if (deviceLocale == null) {
        _logger.warning(
          runtimeType,
          "_getDefaultLangToUse: Couldn't retrieve the device locale, defaulting to english",
        );
        return AppLanguageType.english;
      }

      final appLang = languagesMap.entries.firstWhereOrNull(
            (val) => val.value.code == deviceLocale.languageCode,
      );
      if (appLang == null) {
        _logger.info(
          runtimeType,
          "_getDefaultLangToUse: Couldn't find an appropriate app language for = ${deviceLocale.languageCode}_${deviceLocale.countryCode}, defaulting to english",
        );
        return AppLanguageType.english;
      }

      _logger.info(
        runtimeType,
        '_getDefaultLangToUse: Found an appropriate language to use for = ${deviceLocale.languageCode}_${deviceLocale.countryCode}, that is = ${appLang.key}',
      );
      return appLang.key;
    } catch (e, s) {
      _logger.error(
        runtimeType,
        '_getDefaultLangToUse: Unknown error occurred',
        ex: e,
        trace: s,
      );
      return AppLanguageType.english;
    }
  }

  Future<bool> clear() async {
    await _prefs.clear();
    await init();
    isFirstInstall = false;
    return Future.value(true);
  }
}
