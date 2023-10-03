import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

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
            child: LocationScreen(),
          ),
        ),
      ),
    );
  }
}


class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  String locationString="";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,

      children: [
        Text(locationString),
        ElevatedButton(onPressed: () async{

          var p=await getLocation();

          setState(() {
            locationString= " current location is ${p?.latitude} ,${p?.longitude}";
          });
        }, child: Text("Get Location"))
      ],
    );
  }


  // check service is enabled
  // check permission
  // return position instance

 Future<Position?> getLocation()async{
    Position? p;

    var service=await Geolocator.isLocationServiceEnabled();
    if(service==false){
      Fluttertoast.showToast(msg: "your Location service is disabled");
      return null;
    }

    LocationPermission permission=await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
       permission =await Geolocator.requestPermission();

       if(permission== LocationPermission.denied)
         Fluttertoast.showToast(msg: "your permission request is denied");


         return null;
    }

    if(permission==LocationPermission.deniedForever){
      Fluttertoast.showToast(msg: "your Location Permission is denied you need to enable it");

    return null;
    }









    return await Geolocator.getLastKnownPosition();
  }

}
