import 'package:flutter/material.dart';

import '../../src/index.dart';

InputDecorationTheme getInputDecoration() {
  return InputDecorationTheme(
    filled: true,
    fillColor: ColorManager.white,
    constraints: BoxConstraints(
      maxHeight: getProportionateScreenHeight(61),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: getProportionateScreenWidth(AppPadding.p20),
      vertical: getProportionateScreenHeight(AppPadding.p12 * 2),
    ),
    hintStyle: TextStyleManager.regularTextStyle(
      color: ColorManager.textGrey,
      fontSize: getProportionateScreenHeight(AppSize.s14),
    ),
    labelStyle: TextStyleManager.mediumTextStyle(
      color: ColorManager.grey,
    ),
    errorStyle: TextStyleManager.regularTextStyle(
      color: ColorManager.error,
    ),
    enabledBorder: OutlineInputBorderStyle.getEnabledBorder(),
    focusedBorder: OutlineInputBorderStyle.getEnabledBorder(),
    // errorBorder: UnderLineInptBorderStyle.getErrorBorder(),
    // focusedErrorBorder: UnderLineInptBorderStyle.getFocusedErrorBorder(),
  );
}
