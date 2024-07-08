import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Placemark?> getLocationName(Position? position) async {
    if (position != null) {
      try {
        final placeMark = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        if (placeMark.isNotEmpty) {
          return placeMark[0];
        }
      } catch (e) {
        print("error fetching location name");
      }

      return null;
    }
  }
}
