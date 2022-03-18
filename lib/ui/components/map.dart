import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/manager/api_manager.dart';
import '../../core/model/launchpad.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  int _index = 0;
  List<Launchpad> launchpads = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager().getLaunchpads(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          launchpads = snapshot.data as List<Launchpad>;
          _addMarkers();
          CameraPosition initialPos = CameraPosition(
              target:
                  LatLng(launchpads[_index].latitude, launchpads[_index].longitude),
              zoom: 14.4746);
          return Scaffold(
            body: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: initialPos,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(markers.values),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: _goToTheNextLaunchpad,
              label: const Text('To the next launchpad!'),
              icon: const Icon(Icons.rocket_launch),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> _goToTheNextLaunchpad() async {
    final GoogleMapController controller = await _controller.future;
    _index++;
    if (_index > launchpads.length-1) {
      _index = 0;
    }
    print("index:  ${_index}");
    CameraPosition nextPos = CameraPosition(
        target:
        LatLng(launchpads[_index].latitude, launchpads[_index].longitude),
        zoom: 14.4746);

    controller.animateCamera(CameraUpdate.newCameraPosition(nextPos));
  }

  void _addMarkers() {
    for (int i = 0; i < launchpads.length; i++) {
      var markerIdVal = i.toString();
      final MarkerId markerId = MarkerId(markerIdVal);

      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          launchpads[i].latitude,
          launchpads[i].longitude,
        ),
        infoWindow: InfoWindow(title: launchpads[i].name, snippet: launchpads[i].region),
      );

      // adding a new marker to map
      markers[markerId] = marker;
    }
  }
}
