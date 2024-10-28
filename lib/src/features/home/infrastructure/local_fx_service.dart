import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/country/country.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';

class LocalFXService {
  LocalFXService(this._fastForexService, this._currencyBeaconService);

  final FastForexService _fastForexService;
  final CurrencyBeaconService _currencyBeaconService;

  Future<List<Pair>> getPairsFromCurrencyCode(String currencyCode) async {
    try {
      final pairs = await _fastForexService.getLatestRatesWithChanges(
        base: currencyCode,
      );
      return pairs;
    } catch (_) {
      try {
        final pairs = await _currencyBeaconService.getLatestRatesWithChanges(
          base: currencyCode,
        );
        return pairs;
      } catch (_) {
        final fallbackCode = fallbackCountry.currencyCode;
        if (currencyCode != fallbackCode) {
          throw DefaultError(
            'Could not get rates for $currencyCode. Loading rates for ${fallbackCountry.isoCode}($fallbackCode) as fallback',
          );
        }
      }
    }

    return [];
  }

  Country getCountryFromIsoCode(String isoCode) {
    try {
      return countries.firstWhere(
        (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception('Unsupported ISO code provided');
    }
  }

  Future<String?> getIsoCountryCodeFromPosition() async {
    final position = await getPosition();
    if (position == null) return null;

    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        return placemarks.first.isoCountryCode;
      }
    } catch (_) {}

    return null;
  }

  Future<Position?> getPosition() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (_) {
      position = await Geolocator.getLastKnownPosition();
    }

    return position;
  }
}
