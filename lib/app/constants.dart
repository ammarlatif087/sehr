import 'package:flutter/material.dart';

import '../presentation/src/index.dart';

class Constants {}

const double kDesignHeight = 852.0;
const double kDesignWidth = 393.0;

const kEmpty = "";
const kZero = 0;

enum UserRole { customer, business, non }

enum PaymentType { easyPaisa, visa, jazzCash }

enum Gender { male, female }

enum Status {
  // notLoggedIn,
  // notRegistered,
  // loggedIn,
  // registered,
  // authenticating,
  // registering,
  // loggedOut,
  loading,
  completed,
  error,
}

Text kTextBentonSansReg(
  String text, {
  TextAlign? textAlign,
  double? fontSize,
  Color? color,
  double? letterSpacing,
  double? lineHeight,
  int? maxLines,
  TextOverflow? textOverFlow,
}) {
  return Text(
    text,
    style: TextStyleManager.regularTextStyle(
      fontSize: fontSize ?? getProportionateScreenHeight(14),
      color: color,
      letterSpacing: letterSpacing ?? getProportionateScreenHeight(0.5),
      lineHeight: lineHeight,
    ),
    textAlign: textAlign,
    overflow: textOverFlow,
    maxLines: maxLines,
  );
}

Text kTextBentonSansMed(
  String text, {
  TextAlign? textAlign,
  Color? color,
  double? fontSize,
  double? lineSpacing,
  double? height,
  TextOverflow? overFlow,
  int? maxLines,
  TextDecoration? textDecoration,
}) {
  return Text(
    text,
    style: TextStyleManager.mediumTextStyle(
      fontSize: fontSize ?? getProportionateScreenHeight(14),
      color: color,
      letterSpacing: lineSpacing,
      height: height,
      textDecoration: textDecoration,
    ),
    textAlign: textAlign,
    overflow: overFlow,
    maxLines: maxLines,
  );
}

Text kTextBentonSansBold(
  String text, {
  TextAlign? textAlign,
  double? fontSize,
  Color? color,
}) {
  return Text(
    text,
    style: TextStyleManager.boldTextStyle(
      fontSize: fontSize ?? getProportionateScreenHeight(14),
      color: color,
    ),
    textAlign: textAlign,
  );
}
