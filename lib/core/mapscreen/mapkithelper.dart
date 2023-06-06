// Checked with Source Downloaded.
import 'package:maps_toolkit/maps_toolkit.dart';

class MapKitHelper{

  static double getMarkerRotation (sourceLat, sourceLng, dropOffLat, dropOffLng) {

    var rotation = SphericalUtil.computeHeading(
        LatLng(sourceLat, sourceLng),
        LatLng(dropOffLat, dropOffLng),
    );

    return rotation.toDouble();
  }
}