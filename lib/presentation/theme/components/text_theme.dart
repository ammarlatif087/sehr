import 'package:flutter/material.dart';

import '../../src/index.dart';

TextTheme getTextTheme(BuildContext context) {
  return TextTheme(
    bodyLarge: TextStyleManager.regularTextStyle(),
    bodyMedium: TextStyleManager.regularTextStyle(
      fontSize: 14,
    ).apply(
      color: ColorManager.black,
    ),
  );

  // TextTheme(
  //   headline1: TextStyleManager.semiBoldTextStyle(
  //     textColor: ColorManager.white,
  //     fontSize: FontSize.s16,
  //   ),
  //   headline2: TextStyleManager.semiBoldTextStyle(
  //     textColor: ColorManager.white,
  //     fontSize: FontSize.s16,
  //   ),
  //   headline3: TextStyleManager.semiBoldTextStyle(
  //     textColor: ColorManager.white,
  //     fontSize: FontSize.s16,
  //   ),
  //   headline4: TextStyleManager.semiBoldTextStyle(
  //     textColor: ColorManager.white,
  //     fontSize: FontSize.s16,
  //   ),
  //   headline5: TextStyleManager.semiBoldTextStyle(
  //     textColor: ColorManager.white,
  //     fontSize: FontSize.s16,
  //   ),
  //   headline6: TextStyleManager.semiBoldTextStyle(
  //     textColor: ColorManager.white,
  //     fontSize: FontSize.s16,
  //   ),
  //   subtitle1: TextStyleManager.mediumTextStyle(
  //     color: ColorManager.white,
  //     fontSize: FontSize.s14,
  //   ),
  //   subtitle2: TextStyleManager.mediumTextStyle(
  //     color: ColorManager.white,
  //     fontSize: FontSize.s14,
  //   ),
  //   bodyText1: TextStyleManager.regularTextStyle(
  //     color: ColorManager.white,
  //   ),
  //   caption: TextStyleManager.regularTextStyle(
  //     color: ColorManager.white,
  //   ),
  // );
}
