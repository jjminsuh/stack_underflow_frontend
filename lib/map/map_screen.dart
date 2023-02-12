import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  Completer<GoogleMapController> _controller = Completer();

  static final LatLng companyLatLng = LatLng(
      37.5233273,
      126.921252
  );

  // 확대(Zoom Level)
  static final CameraPosition initialPosition = CameraPosition(
      target: companyLatLng,
      zoom : 15
  );

  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(markerId: MarkerId('1'),
    position: LatLng(32.42796133588664, -122.085749),
      infoWindow: InfoWindow(
        title: "My Position"
      )
    ),
    Marker(markerId: MarkerId('2'),
        position: LatLng(33.738045, -73.084488),
        infoWindow: InfoWindow(
            title: "e-11 sector"
        )
    ),
  ];

  @override
  void initState() {
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: initialPosition,
        ),
      ),
    );
  }
}