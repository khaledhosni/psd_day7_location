import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: MapDemo(),
          ),
        ),
      ),
    );
  }
}

class MapDemo extends StatefulWidget {
  const MapDemo({Key? key}) : super(key: key);

  @override
  State<MapDemo> createState() => _MapDemoState();
}

class _MapDemoState extends State<MapDemo> {

   Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  var cameraPosition= CameraPosition(target: LatLng(31.2608767, 32.2994122)
  ,zoom: 16);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ElevatedButton(onPressed: ()async{
          var gmController=await _controller.future;
          gmController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(32.2608767, 32.2994122),
            zoom: 18
          )
          ));

        }, child: Text(" Go to PSCCHC Location")),

        Expanded(
          child: GoogleMap(initialCameraPosition: cameraPosition
          , mapType: MapType.terrain,
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
          ),
        )

      ],
    );
  }
}
