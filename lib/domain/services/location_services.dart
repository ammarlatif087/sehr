import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationServices {
  final Location location = Location();
  HomeViewModel() {
    myLoction();
  }

  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<Position?> myLoction() async {
    Position? position;
    print("my location caliing");
    position = await _determinePosition();
    // print(
    //     "lat>>>>>>>>>>>>   ${position.latitude}    lng>>>>>>>>>>>>>>>> ${position.longitude * (-1)}");

    return position;
  }
}
