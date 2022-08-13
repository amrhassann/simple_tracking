import 'package:flutter/material.dart';
import 'package:tracking/presentation/res/app_colors.dart';
import 'package:tracking/presentation/res/style_manager.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, required this.onTap, required this.title})
      : super(key: key);
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
        backgroundColor: MaterialStateProperty.all(AppColors.initial),
        shadowColor: MaterialStateProperty.all(Colors.grey[100]),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: getMediumStyle(
            fontSize: 16,
            textColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}
