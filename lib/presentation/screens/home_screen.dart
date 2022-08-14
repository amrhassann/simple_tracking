import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracking/domain/bloc/cubit/app_cubit.dart';
import 'package:tracking/presentation/custom_widgets/custom_app_bar.dart';
import 'package:tracking/presentation/custom_widgets/driver_item.dart';
import 'package:tracking/presentation/res/app_colors.dart';
import 'package:tracking/presentation/screens/map_screen.dart';

class HomeScreen extends StatelessWidget{
  HomeScreen({Key? key, required this.isDriver}) : super(key: key);
  late final bool isDriver;



  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var currentUserName = cubit.userNameController.text;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: customAppbar(title: 'All Drivers'),
      body: StreamBuilder(
        stream: cubit.allDrivers.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // loop in data to get current user id, cuz we will use it when the user GO, to send it by constructor to Map Screen
          snapshot.data?.docs.forEach((element) {
            if(element['name'] == currentUserName){
              cubit.currentUserId = element.id;
            }
          });
          // show loading until data comes or if there is no data
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.initial,
            ));
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (c, i) {
              var snapshotItem = snapshot.data!.docs[i];
              return DriverItem(snapshotItem: snapshotItem, currentUserName: currentUserName,isDriver: isDriver,);
            },
          );
        },
      ),

      // this ActionButton just for the driver, cuz the driver is the only one who'll move and update his location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isDriver?FloatingActionButton(
        backgroundColor: AppColors.initial,
        child: const Text('GO'),
        onPressed: () async{
          await cubit.listenLocation().then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (c)=> MapScreen(cubit.currentUserId, isDriver: isDriver,)));
          });
        },
      ):null,
    );
  }


}



