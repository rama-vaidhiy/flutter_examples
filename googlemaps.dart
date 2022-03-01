import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  late Set<Marker> _markers = {
    Marker(
        position: LatLng(51.178883, -1.826215),
        markerId: MarkerId('1'),
        infoWindow: InfoWindow(title: 'Stonehenge'),
        icon: BitmapDescriptor.defaultMarker),
  };

  static final CameraPosition _defLoc = CameraPosition(
    // target: LatLng(51.48158100000001, -3.1790899999999738),
    //Cardiff
    target: LatLng(55.03244724819317, -3.0171248566431874),
    //zoom: 14.4746,
  );

  static final CameraPosition _kUni = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(51.609836696707895, -3.9789715294263006), //SA2 8PP
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Google Maps')),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _defLoc,
        markers: _markers,
        compassEnabled: true,
        cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            northeast: LatLng(50.00, -3.8), southwest: LatLng(56.00, -1.8))),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        rotateGesturesEnabled: true,
        zoomControlsEnabled: false,
        tiltGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheUni,
        label: Text('To Uni!'),
        icon: Icon(Icons.directions_railway),
      ),
    );
  }

  Future<void> _goToTheUni() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _markers = {
        Marker(
            position: LatLng(51.609836696707895, -3.9789715294263006),
            markerId: MarkerId('1'),
            infoWindow: InfoWindow(title: 'Faraday Building'),
            icon: BitmapDescriptor.defaultMarker),
        Marker(
            position: LatLng(51.60960644941567, -3.980495763970058),
            markerId: MarkerId('2'),
            infoWindow: InfoWindow(title: 'Fulton House'),
            icon: BitmapDescriptor.defaultMarker),
        Marker(
            position: LatLng(51.61078311574144, -3.9773279708211215),
            markerId: MarkerId('3'),
            infoWindow: InfoWindow(title: 'MyUni Hu'),
            icon: BitmapDescriptor.defaultMarker),
      };
    });

    controller.animateCamera(CameraUpdate.newCameraPosition(_kUni));
  }
}
