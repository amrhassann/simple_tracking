import 'package:flutter/material.dart';
import 'package:tracking/presentation/res/app_colors.dart';

class CustomLoginTextField extends StatelessWidget {

  final String? hit;
  TextEditingController? controller;
  Widget? prefixIcon;
  TextInputType keyboardType;
  CustomLoginTextField({Key? key,  this.keyboardType = TextInputType.text  ,this.prefixIcon,this.hit,  this.controller,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      style: const TextStyle(
        color: AppColors.initial,
      ),
      decoration: InputDecoration(
          disabledBorder:buildTextFieldBorder(),
          enabledBorder: buildTextFieldBorder(),
          focusedErrorBorder: buildTextFieldBorder(),
          border: buildTextFieldBorder(),
          focusedBorder: buildTextFieldBorder(),
          hintText: hit,
          hintStyle: const TextStyle( color: Colors.grey),
          filled: true,
          fillColor: AppColors.white,
      ),

      // we are using validation here because this widget is always required, cuz its for login
      validator:(value){
        if (value == null || value.isEmpty) {
          return "$hit is required";
        }
        return null;
      },
    );
  }
  OutlineInputBorder buildTextFieldBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10));
  }
}