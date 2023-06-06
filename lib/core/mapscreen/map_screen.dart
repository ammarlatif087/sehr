// import 'dart:async';
// import 'dart:math';

// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:sehr/presentation/src/colors_manager.dart';

// import '../../presentation/view_models/customer_view_models/home_view_model.dart';

// class MapDirection extends StatefulWidget {
//   double destLatitude;
//   double destLongitude;
//   MapDirection(
//       {super.key, required this.destLatitude, required this.destLongitude});

//   @override
//   _MapDirectionState createState() => _MapDirectionState();
// }

// // Starting point latitude
// double _originLatitude = position!.latitude;

// // Starting point longitude
// double _originLongitude = position!.longitude;
// // Destination latitude
// double? _destLatitude;
// // Destination Longitude
// double? _destLongitude;

// Location location = Location();
// // Markers to show points on the map
// Map<MarkerId, Marker> markers = {};

// PolylinePoints polylinePoints = PolylinePoints();
// Map<PolylineId, Polyline> polylines = {};

// class _MapDirectionState extends State<MapDirection> {
//   //update location
//   checklocation() async {
//     position = await Geolocator.getCurrentPosition();
//     _originLatitude = position!.latitude;
//     _originLongitude = position!.longitude;
//     if (this.mounted) {
//       setState(() {});
//     }
//   }

// //map controller
//   GoogleMapController? mapController;
//   // Configure map position and zoom

// //int variable and fetch kilometers to measure distance between user and shop
//   int km = 0;
//   fetchkm() async {
//     if (this.mounted) {
//       setState(() {
//         km = calculateDistance(_originLatitude, _originLongitude, _destLatitude,
//                 _destLongitude)
//             .truncate();
//       });
//     }
//   }

//   //timer listener to update every thing continously
//   Timer? _timer;
//   locationListener() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       //update location
//       checklocation();
//       //update distance
//       fetchkm();
//       //update markers
//       _addMarker(
//         LatLng(_originLatitude, _originLongitude),
//         "origin",
//         BitmapDescriptor.defaultMarker,
//       );
//       //update lines
//       _getPolyline();

//       //check distance
//       if (km < 1) {
//         showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                 ),
//               );
//             });
//         timer.cancel();
//       }
//     });
//   }

// //dispose everything
//   @override
//   void dispose() {
//     _timer!.cancel();
//     mapController!.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   bool issatellite = false;

//   @override
//   void initState() {
//     _destLatitude = widget.destLatitude;
//     _destLongitude = widget.destLongitude;

//     /// add origin marker origin marker
//     _addMarker(
//       LatLng(_originLatitude, _originLongitude),
//       "origin",
//       BitmapDescriptor.defaultMarker,
//     );

//     // Add destination marker
//     _addMarker(
//       LatLng(_destLatitude!, _destLongitude!),
//       "destination",
//       BitmapDescriptor.defaultMarkerWithHue(90),
//     );

//     _getPolyline();
//     fetchkm();
//     locationListener();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//           appBar: AppBar(
//             leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.arrow_back_ios)),
//             backgroundColor: ColorManager.primary,
//             title: const Text('Map View '),
//             actions: [
//               SizedBox(
//                 height: 30,
//                 width: 150,
//                 child: Row(
//                   children: [
//                     Checkbox(
//                         activeColor: Colors.white,
//                         checkColor: ColorManager.primary,
//                         value: issatellite,
//                         onChanged: (a) {
//                           if (this.mounted) {
//                             setState(() {
//                               issatellite = !issatellite;
//                             });
//                           }
//                         }),
//                     const Text("Satellite Mode")
//                   ],
//                 ),
//               )
//             ],
//           ),
//           body: Stack(
//             children: [
//               GoogleMap(
//                 mapType: issatellite ? MapType.satellite : MapType.normal,
//                 initialCameraPosition: CameraPosition(
//                     target: LatLng(_destLatitude!, _destLongitude!), zoom: 17),
//                 myLocationEnabled: true,
//                 tiltGesturesEnabled: true,
//                 compassEnabled: true,
//                 scrollGesturesEnabled: true,
//                 zoomGesturesEnabled: true,
//                 circles: {
//                   Circle(
//                       circleId: const CircleId("1"),
//                       center: LatLng(_destLatitude!, _destLongitude!),
//                       radius: 500,
//                       fillColor: const Color(0xff006491).withOpacity(0.2),
//                       strokeWidth: 2),
//                 },
//                 polylines: Set<Polyline>.of(polylines.values),
//                 markers: Set<Marker>.of(markers.values),
//                 onMapCreated: (GoogleMapController controller) {
//                   if (this.mounted) {
//                     setState(() {
//                       mapController = controller;
//                       LatLng newlatlang =
//                           LatLng(_originLatitude, _originLongitude);

//                       Future.delayed(const Duration(seconds: 5), () {
//                         mapController?.animateCamera(
//                             CameraUpdate.newCameraPosition(CameraPosition(
//                           target: newlatlang,
//                           zoom: 15,
//                         )
//                                 //17 is new zoom level
//                                 ));
//                       });
//                     });
//                   }
//                   // _controller.complete(controller);
//                 },
//               ),
//               Positioned(
//                   bottom: 50,
//                   left: 20,
//                   right: 20,
//                   child: Container(
//                       color: ColorManager.primary,
//                       child: Card(
//                         elevation: 0,
//                         child: Container(
//                             color: ColorManager.primary,
//                             padding: const EdgeInsets.all(20),
//                             child: Column(
//                               children: [
//                                 Text(
//                                     "${"Duration:                ${km / 50}"} H ",
//                                     style: const TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold)),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text("${"Total Distance:     $km"} KM",
//                                     style: const TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold)),
//                               ],
//                             )),
//                       )))
//             ],
//           )),
//     );
//   }

//   // This method will add markers to the map based on the LatLng position
//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//         Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }

//   _addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = const PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id,
//         points: polylineCoordinates,
//         width: 4,
//         color: Colors.green);
//     polylines[id] = polyline;
//     if (this.mounted) {
//       setState(() {
//         // Your state change code goes here
//       });
//     }
//   }

//   void _getPolyline() async {
//     List<LatLng> polylineCoordinates = [];

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "AIzaSyAM0iMSY3HUOoCaR8SLSpYmobiC3QgL9rY",
//       PointLatLng(_originLatitude, _originLongitude),
//       PointLatLng(_destLatitude!, _destLongitude!),
//       travelMode: TravelMode.driving,
//     );
//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     } else {
//       print(result.errorMessage);
//     }
//     _addPolyLine(polylineCoordinates);
//   }

//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var a = 0.5 -
//         cos((lat2 - lat1) * p) / 2 +
//         cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }
// }
