import 'package:flutter/material.dart';
import 'package:tracking/presentation/res/app_colors.dart';
import 'package:tracking/presentation/res/style_manager.dart';

PreferredSizeWidget customAppbar({
  required String title,
  List<Widget>? actions,
  Color backgroundColor = AppColors.white,
}){
  return AppBar(
    iconTheme: const IconThemeData(
        color: AppColors.grey
    ),
    backgroundColor: backgroundColor,
    elevation: 0.0,
    centerTitle: true,
    title:  Text(title, style: getMediumStyle(fontSize: 18, textColor: AppColors.grey),),
    actions: actions,
  );
}