import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/country/country.dart';

class LocalFXService {
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
    final position = await _getPosition();
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

  Future<Position?> _getPosition() async {
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
