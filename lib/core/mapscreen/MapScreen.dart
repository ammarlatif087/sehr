// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:math';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/core/mapscreen/mapkithelper.dart';
import 'package:sehr/presentation/src/assets_manager.dart';
import 'package:sehr/presentation/src/colors_manager.dart';

import 'package:sehr/presentation/views/customer_views/scanner/scanner_view.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../presentation/view_models/customer_view_models/home_view_model.dart';
import '../../presentation/views/customer_views/shop/ButtonContact.dart';

class MapDirection extends StatefulWidget {
  double destLatitude;
  double destLongitude;
  String phonenumber;
  String shopname;
  MapDirection(
      {super.key,
      required this.phonenumber,
      required this.destLatitude,
      required this.destLongitude,
      required this.shopname});

  @override
  _MapDirectionState createState() => _MapDirectionState();
}

// Starting point latitude
double _originLatitude = position!.latitude;

// Starting point longitude
double _originLongitude = position!.longitude;
// Destination latitude
double? _destLatitude;
// Destination Longitude
double? _destLongitude;

Location location = Location();
// Markers to show points on the map
Map<MarkerId, Marker> markers = {};

PolylinePoints polylinePoints = PolylinePoints();
Map<PolylineId, Polyline> polylines = {};

class _MapDirectionState extends State<MapDirection> {
  void getLocationUpdates() {
    LatLng oldPosition = const LatLng(0, 0);

    ridePositionStream =
        Geolocator.getPositionStream(locationSettings: const LocationSettings())
            .listen((Position positionmap) {
      position = positionmap;
      _originLatitude = positionmap.latitude;
      _originLongitude = positionmap.longitude;
      if (mounted) {
        setState(() {});
      }

      LatLng pos = LatLng(_originLatitude, _originLongitude);

      var rotaton = MapKitHelper.getMarkerRotation(oldPosition.latitude,
          oldPosition.longitude, pos.latitude, pos.longitude);

      // ignore: unused_local_variable
      Marker movingMarker = Marker(
        markerId: const MarkerId('moving'),
        position: pos,
        icon: movingMarkerIcon,
        rotation: rotaton,
        infoWindow: const InfoWindow(title: 'Current Location'),
      );

      setState(() {
        CameraPosition cp = CameraPosition(target: pos, zoom: 15);
        mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

        // ignore: unrelated_type_equality_checks
        markers.removeWhere((key, value) => value.markerId.value == 'origin');
      });

      oldPosition = pos;
    });
  }

//map controller
  late GoogleMapController mapController;
  // Configure map position and zoom

//int variable and fetch kilometers to measure distance between user and shop
  int km = 0;
  fetchkm() async {
    if (mounted) {
      setState(() {
        km = calculateDistance(_originLatitude, _originLongitude, _destLatitude,
                _destLongitude)
            .truncate();
      });
    }
  }

  //timer listener to update every thing continously
  Timer? _timer;
  locationListener() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //update location

      //update distance
      fetchkm();
      //update markers

      //update lines
      _getPolyline();

      //check distance
    });
  }

//dispose everything
  @override
  void dispose() {
    _timer!.cancel();
    mapController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  bool issatellite = false;

  @override
  void initState() {
    getLocationUpdates();
    _destLatitude = widget.destLatitude;
    _destLongitude = widget.destLongitude;

    /// add origin marker origin marker
    _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude!, _destLongitude!),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    _getPolyline();
    fetchkm();
    locationListener();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            backgroundColor: ColorManager.primary,
            title: const Text('Map View '),
            actions: [
              SizedBox(
                height: 30,
                width: 150,
                child: Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: ColorManager.primary,
                        value: issatellite,
                        onChanged: (a) {
                          if (mounted) {
                            setState(() {
                              issatellite = !issatellite;
                            });
                          }
                        }),
                    const Text("Satellite Mode")
                  ],
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              GoogleMap(
                mapType: issatellite ? MapType.satellite : MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(_destLatitude!, _destLongitude!), zoom: 17),
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                polylines: Set<Polyline>.of(polylines.values),
                markers: Set<Marker>.of(markers.values),
                onMapCreated: (GoogleMapController controller) {
                  if (mounted) {
                    setState(() {
                      mapController = controller;
                      LatLng newlatlang =
                          LatLng(_originLatitude, _originLongitude);

                      Future.delayed(const Duration(seconds: 5), () {
                        mapController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                          target: newlatlang,
                          zoom: 15,
                        )
                                //17 is new zoom level
                                ));
                      });
                    });
                  }
                  // _controller.complete(controller);
                },
              ),
              Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: km > 0
                      ? Container(
                          height: 250,
                          decoration: BoxDecoration(
                              color: const Color(0xffF9FCFF).withOpacity(0.90),
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Track Shop",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              Container(
                                height: 100,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        color: Colors.black,
                                        child: Image.asset(
                                          AppImages.restourant,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                          child: ListTile(
                                              title: Text(
                                                  widget.shopname.toString()),
                                              subtitle: Row(
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        color: ColorManager
                                                            .primary,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      "${"${km / 50}"} Hours away ")
                                                ],
                                              )))
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ButtonContact(
                                  title: "CAll",
                                  onPressed: () {
                                    UrlLauncher.launch(
                                        "tel://${widget.phonenumber}");
                                  },
                                  color: HexColor.fromHex('#15BE77')),
                            ],
                          ))
                      : Container(
                          height: 270,
                          decoration: BoxDecoration(
                              color: const Color(0xffF9FCFF).withOpacity(0.90),
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Track Shop",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Icon(Icons.done),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                color: ColorManager.primary.withOpacity(0.6),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        color: Colors.black,
                                        child: Image.asset(
                                          AppImages.restourant,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                          child: ListTile(
                                              title: Text(
                                                widget.shopname.toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape
                                                                .circle),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    "Reached",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )))
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      UrlLauncher.launch(
                                          "tel://${widget.phonenumber}");
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: ColorManager.primary,
                                          ),
                                          Text(
                                            "Call",
                                            style: TextStyle(
                                                color: ColorManager.primary),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      // final viewModel = Provider.of<
                                      //         CustomerBottomNavViewModel>(
                                      //     context,
                                      //     listen: false);
                                      // MaterialPageRoute(builder: (context) {
                                      //   return ChangeNotifierProvider.value(
                                      //       value: viewModel,
                                      //       child: ScannerView());
                                      // });
                                      Get.to(() => ScannerView());
                                      // Navigator.push(
                                      //   context,d
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const ScannerView()),
                                      // );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.scanner,
                                            color: ColorManager.primary,
                                          ),
                                          Text(
                                            "Scan",
                                            style: TextStyle(
                                                color: ColorManager.primary),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )))
            ],
          )),
    );
  }

  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        points: polylineCoordinates,
        width: 4,
        color: Colors.green);
    polylines[id] = polyline;
    if (mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAM0iMSY3HUOoCaR8SLSpYmobiC3QgL9rY",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude!, _destLongitude!),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  late Position currentPosition;
  late StreamSubscription<Position> ridePositionStream;
  BitmapDescriptor movingMarkerIcon = BitmapDescriptor.defaultMarker;

  late Position myPosition;
}
