import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking/data/location.dart';
import 'package:tracking/domain/bloc/cubit/app_cubit.dart';
import 'package:tracking/presentation/res/app_colors.dart';


class MapScreen extends StatefulWidget {
   MapScreen(this.userId, {Key? key , required this.isDriver}) : super(key: key);

  final String userId;
   late bool isDriver ;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller ;
  bool added = false;
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit();
    return Scaffold(

      body: StreamBuilder(
        stream: cubit.allDrivers.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){

          var target = LatLng(
            snapshot.data?.docs.singleWhere(
                    (element) => element.id == widget.userId)['latitude'],
            snapshot.data?.docs.singleWhere(
                    (element) => element.id == widget.userId)['longitude'],

          );

          if(added){
            changeCameraPosition(snapshot, target);
          }
          if(!snapshot.hasData || snapshot == null){
            return const Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            polylines: cubit.pathPolyline,
            mapType: MapType.normal,
            markers: {
               Marker(
                position: target ,
                  markerId: const MarkerId('id'),
                  icon: BitmapDescriptor.defaultMarker
              ),
            },

            initialCameraPosition: CameraPosition(
            zoom: 16,
            target: target),
            onMapCreated: (GoogleMapController controller)async{
              Future.delayed(const Duration(seconds: 15),(){
                // that means, new location will update every 15 seconds
                setState(() {
                  _controller = controller;
                  added = true;
                });
              });
            },


          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.isDriver?FloatingActionButton(
        backgroundColor: AppColors.initial,
        onPressed: (){
        LocationHelper locationHelper= LocationHelper();
        setState(() {
          locationHelper.locationSubscription?.cancel();
          locationHelper.locationSubscription = null;
        });
        Navigator.pop(context);
      },
        child: const Icon(Icons.clear),):null,
    );
  }

  Future<void> changeCameraPosition(AsyncSnapshot<QuerySnapshot> snapshot, target)async{
    await _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: target,
        zoom: 16
      ),
    )
    );
  }

}
