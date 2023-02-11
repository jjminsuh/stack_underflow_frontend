import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  // latitude - 위도 , longtitude - 경도
  static final LatLng companyLatLng = LatLng(
      37.5233273,
      126.921252
  );

  // 확대(Zoom Level)
  static final CameraPosition initialPosition = CameraPosition(
      target: companyLatLng,
      zoom : 15
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          // 처음에 어떤 위치에서 바라볼지
          initialCameraPosition: initialPosition,
        )
    );
  }
}
