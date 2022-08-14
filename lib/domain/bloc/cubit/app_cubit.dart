
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:tracking/data/location.dart';
import 'package:tracking/data/repository/send_driver_data.dart';
import 'package:tracking/domain/bloc/states/app_states.dart';
import 'package:tracking/presentation/res/app_colors.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  // cubit getter
  static AppCubit get(context) => BlocProvider.of(context);

  // text editing controllers
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // instances
  SendDriverData sendUserData = SendDriverData();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  LocationHelper locationHelper = LocationHelper();
  LocationPermission sendRequest = LocationPermission();

  // Collection that get all drivers from firestore
  CollectionReference<Map<String, dynamic>> allDrivers =  FirebaseFirestore.instance.collection('location');
  late String currentUserId;



  // start send location request to the user
  sendLocationRequest()async{
    await sendRequest.requestPermission();
  }
  // end send location request to the user

  // start sending user driver data and location
  driverLogin(){
    emit(LoginLoadingState());
    sendUserData.send(name: userNameController.text, phone: userPhoneNumberController.text).then((value) {
      emit(LoginSuccessState());
    }).onError((error, stackTrace){
      print('auth error: $error');
      emit(LoginErrorState(error.toString()));
    });
  }
// end sending user data and location


//start admin login -> firebase email and password authentication
  adminLogin()async{
    firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
      emit(LoginSuccessState());
    }).onError((error, stackTrace) {
      emit(LoginErrorState(error.toString()));
    });
  }
//end admin login -> firebase email and password authentication


  Set<Polyline> pathPolyline = <Polyline>{};
  List<LatLng>points= <LatLng>[];
//start update driver location method

  Future<void> listenLocation() async {
    locationHelper.locationSubscription = locationHelper.location.onLocationChanged.handleError((error) {
      log('Update driver location error -> ${error.toString()}');
        locationHelper.locationSubscription?.cancel();
        locationHelper.locationSubscription = null;

        emit(UpdateDriverLocationError(error));

    }).listen((loc.LocationData currentLocation) async {
      await FirebaseFirestore.instance.collection('location').doc(currentUserId).set({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
      },
       SetOptions(merge: true));
      LatLng latLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);

      points.add(latLng);
      pathPolyline.add(
        Polyline(
            polylineId: const PolylineId('1'),
            color: AppColors.initial,
            width: 5,
            points:points,
            patterns: [
              PatternItem.dash(20),
              PatternItem.gap(10),
            ]

        ),
      );
      emit(UpdateDriverSuccessState());
    });
  }
//end update driver location method


}