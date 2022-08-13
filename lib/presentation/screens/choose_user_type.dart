import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking/presentation/custom_widgets/user_type_item.dart';
import 'package:tracking/presentation/res/app_colors.dart';
import 'package:tracking/presentation/res/style_manager.dart';
import 'package:tracking/presentation/screens/login/admin_login_screen.dart';
import 'package:tracking/presentation/screens/login/driver_login_screen.dart';

class ChooseUserType extends StatelessWidget {
  // we are using this screen to select uer type,
  // so if the user is admin he/she can just track shipments on the map without sending his/her location to database
  // if user is driver, will send his location, name, and phone number.

  const ChooseUserType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        centerTitle: true,
        title:  Text('User Type', style: getMediumStyle(fontSize: 18, textColor: AppColors.grey),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserTypeItem(title: 'Truck Driver', onTap: () {
            // here we are getting the driver location to send it when he login
            requestPermission();
            Navigator.push(context, MaterialPageRoute(builder: (c)=> DriverLogin()));
          },),
          UserTypeItem(title: 'Admin', onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (c)=> AdminLogin()));
          },),
        ],
      ),
    );
  }

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

