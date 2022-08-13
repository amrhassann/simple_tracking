import 'package:flutter/material.dart';

_getTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required Color color,
}) {
  return TextStyle(
    fontFamily: 'Cairo',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

//regular style
getRegularStyle({
  required double fontSize,
  required Color textColor,
}){
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: textColor,
  );
}

//medium style
getMediumStyle({
  required double fontSize,
  required Color textColor,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: textColor,
  );
}

//semi bold style
getSemiBoldStyle({
  required double fontSize,
  required Color textColor,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: textColor,
  );
}

// bold style
getBoldStyle({
  required double fontSize,
  required Color textColor,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
}

