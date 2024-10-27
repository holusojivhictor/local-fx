import 'package:intl/date_symbol_data_local.dart';
import 'package:local_fx/src/features/common/domain/enums/app_language_type.dart';
import 'package:local_fx/src/features/common/infrastructure/locale_service.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

void manuallyInitLocale(LocaleService service, AppLanguageType language) {
  final locale = service.getFormattedLocale(language);
  initializeDateFormatting(locale);
}

LocaleService getLocaleService(AppLanguageType language) {
  final preferenceService = MockPreferenceService();
  when(preferenceService.language).thenReturn(language);
  final service = LocaleService(preferenceService);
  manuallyInitLocale(service, language);
  return service;
}
