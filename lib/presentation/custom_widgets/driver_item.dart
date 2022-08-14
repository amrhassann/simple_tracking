
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracking/presentation/res/app_colors.dart';
import 'package:tracking/presentation/screens/map_screen.dart';

class DriverItem extends StatelessWidget {
  const DriverItem({Key? key, required this.currentUserName, required this.snapshotItem, required this.isDriver}) : super(key: key);

  final QueryDocumentSnapshot<Object?> snapshotItem;
  final String currentUserName;
  final bool isDriver;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        // this statement to replace the current user name with 'You'
          title: Text(snapshotItem['name'].toString() == currentUserName
              ? 'You'
              : snapshotItem['name'].toString()),
          subtitle: Text(snapshotItem['phone'].toString()),

          trailing: snapshotItem['name'].toString() != currentUserName
              ? IconButton(
            icon: const Icon(Icons.directions),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => MapScreen(snapshotItem.id,isDriver: isDriver,)));
            },
          )
              : null),
    );
  }
}