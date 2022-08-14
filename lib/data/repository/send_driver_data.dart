
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracking/data/location.dart';

class SendDriverData extends GetLocation{
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