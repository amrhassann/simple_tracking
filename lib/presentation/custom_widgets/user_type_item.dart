
import 'package:flutter/material.dart';
import 'package:tracking/presentation/res/app_colors.dart';
import 'package:tracking/presentation/res/style_manager.dart';

class UserTypeItem extends StatelessWidget {
  // this widget to select user type

  const UserTypeItem({
    Key? key,
    required this.title,
    required this.onTap
  }) : super(key: key);

  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child:  Center(child: Text(title, style: getMediumStyle(fontSize: 18, textColor: AppColors.white),),),
      ),
    );
  }
}