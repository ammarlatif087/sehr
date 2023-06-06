import 'package:flutter/material.dart';

import '../../src/index.dart';

AppBarTheme getAppBarTheme() {
  return AppBarTheme(
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: ColorManager.white,
    // ),
    centerTitle: true,
    color: ColorManager.primary,
    shadowColor: ColorManager.primary,
    elevation: AppSize.s4,
    titleTextStyle: TextStyleManager.regularTextStyle(
      color: ColorManager.white,
      fontSize: FontSize.s16,
    ),
  );
}
