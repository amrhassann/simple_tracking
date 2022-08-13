import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class LocationHelper {
  loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? locationSubscription;
}

class GetLocation extends LocationHelper {
   loc.LocationData? locationResult;

   getLocation() async {
     locationResult = await location.getLocation();
     print('longitude is: ${locationResult?.longitude}');
  }
}

class SendUserData extends GetLocation{
  Future send({required String name, required String phone})async{
    await getLocation();
    print('getLocation done');
    await FirebaseFirestore.instance.collection('location').doc().set({
      'latitude': locationResult!.latitude,
      'longitude': locationResult!.longitude,
      'name': name,
      'phone': phone
    }, );
  }
}





class SendRequest extends LocationHelper{
  requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      log('done');
    } else if (status.isDenied) {
      requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
