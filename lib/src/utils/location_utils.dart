import 'package:geolocator/geolocator.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';

class LocationUtils {
  static Future<void> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const DefaultError('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const DefaultError('Location permissions have been denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const DefaultError(
        'Location permissions are permanently denied. Allow permissions from phone settings.',
      );
    }
  }
}
