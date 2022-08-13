import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tracking/presentation/screens/start_view.dart';
import 'firebase_options.dart';

void main() async{
  await initilizeFirebase();
  runApp(const StartView());
}


 initilizeFirebase ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    log('firebase initialized successfully');
  }).onError((error, stackTrace) {
    log('firebase initialize error: ${error.toString()}');
  });
}





