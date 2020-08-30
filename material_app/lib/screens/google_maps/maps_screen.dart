import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_app/constants.dart';

//* Get an API key at https://cloud.google.com/maps-platform/.

class MapsScreen extends StatefulWidget {
  static const routeName = '/maps-screen';

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  //* set of markers to be displayed on Map
  final Set<Marker> _markers = {};

  //* Random Initial location
  LatLng _location = LatLng(22, 74);

  _onMapCreated(GoogleMapController controller) async {
    //* getting current location of user
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      //* setting location of user
      _location = LatLng(position.latitude, position.longitude);

      //* adding marker at current location
      _markers.add(
        Marker(
          markerId: MarkerId('Current Location'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: 'lat: ${position.latitude} , lon: ${position.longitude},',
          ),
        ),
      );

      //* setting dark mode
      //! kDarkStyle is a JSON Object (see full code for more info)
      controller.setMapStyle(kDarkStyledMaps);

      //* animating camera to current location after a second
      Future.delayed(Duration(seconds: 1), () {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _location,
              tilt: 10.0,
              bearing: 25.0,
              zoom: 10.0,
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
        centerTitle: true,
      ),
      body: GoogleMap(
        //* set initial camera position
        initialCameraPosition: CameraPosition(
          target: _location,
          zoom: 1,
        ),
        onMapCreated: _onMapCreated,

        //* markers to be displayed on map
        markers: _markers,

        //* normal, satellite, terrain, none (no titles)
        mapType: MapType.normal,

        //* displays a button for getting
        //* approximate current location
        myLocationEnabled: true,
      ),
    );
  }
}
